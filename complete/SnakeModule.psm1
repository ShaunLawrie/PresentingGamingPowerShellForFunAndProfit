$script:oppositeDirections = @{
    "LeftArrow" = "RightArrow"
    "RightArrow" = "LeftArrow"
    "UpArrow" = "DownArrow"
    "DownArrow" = "UpArrow"
}
$script:PowershellSounds = $null
$script:PowershellMusic = $null
$script:Runspace = $null
$script:SoundHandle = $null

function Convert-HueToRgb {
    param(
        [int] $Hue
    )

    $chroma = 1.0
    $H = $Hue / 60.0
    $X = $chroma * (1.0 - [Math]::Abs($H % 2 - 1))

    $m = 1.0 - $chroma
    $rgb = @($m, $m, $m)

    $xIndex = (7 - [Math]::Floor($H)) % 3
    $cIndex = [int]($H / 2) % 3

    $rgb[$xIndex] += $X
    if($xIndex -eq $cIndex) {
        $rgb[($cIndex + 1) % 3] += $chroma
    } else {
        $rgb[$cIndex] += $chroma
    }
    
    return @(
       [int]($rgb[0] * 255),
       [int]($rgb[1] * 255),
       [int]($rgb[2] * 255)
    )
}

function Update-PowerUp {
    param (
        [hashtable] $PowerUp,
        [int] $PowerUpInterval,
        [int] $PowerUpLifetime
    )
    if(($global:frameCount % $PowerUpInterval) -eq 0) {
        if($null -eq $PowerUp) {
            return New-PowerUp -PowerUpLifetime $PowerUpLifetime
        }
    }
    if($null -ne $powerUp) {
        $PowerUp.Timeout--
        if($PowerUp.Timeout -lt 0) {
            return $null
        } else {
            return $PowerUp
        }
    }
}

function Test-IsSnake {
    param (
        [hashtable] $Position,
        [switch] $ExcludeHead,
        [bool] $PoweredUp = $false
    )
    if($PoweredUp) {
        return $false
    }

    if($ExcludeHead -and $global:snake.Count -gt 1) {
        $thisSnake = $global:snake[0..($global:snake.Count - 2)]
    } else {
        $thisSnake = $global:snake
    }
    foreach($segment in $thisSnake) {
        if($segment.X -eq $Position.X -and $segment.Y -eq $Position.Y) {
            return $true
        }
    }
    return $false
}

function Test-IsFood {
    param (
        [hashtable] $Position,
        [hashtable] $Food
    )
    if($Food.X -eq $Position.X -and $Food.Y -eq $Position.Y) {
        return $true
    } else {
        return $false
    }
}

function Test-IsPowerUp {
    param (
        [hashtable] $Position,
        [hashtable] $PowerUp
    )
    if($PowerUp.X -eq $Position.X -and $PowerUp.Y -eq $Position.Y) {
        return $true
    } else {
        return $false
    }
}

function Get-LastKeyPressed {
    if([Console]::KeyAvailable) {
        $key = $null
        while([Console]::KeyAvailable) {
            $key = [Console]::ReadKey($true)
        }
        return $key
    } else {
        return $null
    }
}

function Add-SnakeHead {
    param (
        [string] $Direction
    )

    $lastPosition = $global:snake[$global:snake.Count - 1]

    $newPosition = @{
        X = $lastPosition.X
        Y = $lastPosition.Y
    }

    switch($Direction) {
        "LeftArrow" {
            $newPosition.X--
        }
        "RightArrow" {
            $newPosition.X = ($newPosition.X + 1) % $global:gameWidth
        }
        "UpArrow" {
            $newPosition.Y--
        }
        "DownArrow" {
            $newPosition.Y = ($newPosition.Y + 1) % $global:gameHeight
        }
    }

    if($newPosition.X -lt 0) {
        $newPosition.X = $global:gameWidth - 1
    }

    if($newPosition.Y -lt 0) {
        $newPosition.Y = $global:gameHeight - 1
    }
    
    $global:snake = $global:snake + $newPosition

    return $Direction
}

function Remove-SnakeTail {
    $global:snake = $global:snake[1..($global:snake.Count - 1)]
}

function Test-DirectionAllowed {
    param (
        [string] $CurrentDirection,
        [string] $NewDirection,
        [array] $Directions
    )
    if($Directions -notcontains $NewDirection) {
        return $false
    }
    $oppositeDirection = $script:oppositeDirections[$CurrentDirection]
    if($global:snake.Count -gt 1 -and $oppositeDirection -eq $NewDirection) {
        return $false
    } else {
        return $true
    }
}

function New-Food {
    do {
        $newFood = @{
            X = (Get-Random -Minimum 0 -Maximum $global:gameWidth)
            Y = (Get-Random -Minimum 0 -Maximum $global:gameHeight)
        }
    } until (-not(Test-IsSnake -Position $newFood))
    return $newFood
}

function New-PowerUp {
    param (
        [int] $PowerUpLifetime
    )
    do {
        $newPowerUp = @{
            X = (Get-Random -Minimum 0 -Maximum $global:gameWidth)
            Y = (Get-Random -Minimum 0 -Maximum $global:gameHeight)
            Timeout = $PowerUpLifetime
        }
    } until (-not(Test-IsSnake -Position $newPowerUp))
    return $newPowerUp
}

function Write-GameGrid {
    param (
        [int] $Score,
        [hashtable] $Food,
        [hashtable] $PowerUp,
        [int] $PoweredUp,
        [int] $PowerUpLifetime,
        [int] $PoweredUpLifetime,
        [int] $Padding
    )
    $escape = [char]0x1b
    $paddingCode = ""
    if($Padding) {
        $paddingCode = "$escape[${Padding}C"
    }
    $screen = [System.Text.StringBuilder]::new($x * 2 * $y + $y)
    for($y = 0; $y -lt $global:gameHeight; $y++) {
        $null = $screen.Append($paddingCode)
        for($x = 0; $x -lt $global:gameWidth; $x++) {
            $isSnake = 0
            for($s = 0; $s -lt $global:snake.Count; $s++) {
                $segment = $global:snake[$s]
                if($segment.X -eq $x -and $segment.Y -eq $y) {
                    $isSnake = $s + 1
                    break
                }
            }
            if($isSnake) {
                if($PoweredUp) {
                    $h = ((($isSnake * 10) + $global:frameCount * 20) % 359)
                    $rgb = Convert-HueToRgb -Hue $h
                    $r = $rgb[0]
                    $g = $rgb[1]
                    $b = $rgb[2]
                    if($PoweredUp -lt ($PoweredUpLifetime / 4) -and $global:frameCount % 2 -eq 0) {
                        $r = [Math]::Max(20, $rgb[0] - 80)
                        $g = [Math]::Max(20, $rgb[1] - 80)
                        $b = [Math]::Max(20, $rgb[2] - 80)
                    }
                } else {
                    $r = 0
                    $g = [Math]::Min(0 + (($global:snake.Count - $isSnake) * 15), 120)
                    $b = 0
                }
                $null = $screen.Append("$escape[38;2;155;200;9m$escape[48;2;${r};${g};${b}m░░$escape[0m")
            } elseif($Food.Y -eq $y -and $Food.X -eq $x) {
                $null = $screen.Append("$escape[30;41m  $escape[0m")
            } elseif($null -ne $PowerUp -and $PowerUp.Y -eq $y -and $PowerUp.X -eq $x) {
                if($PowerUp.Timeout -lt ($PowerUpLifetime / 4)) {
                    if($global:frameCount % 2 -eq 0) {
                        $null = $screen.Append("$escape[0;30m$escape[48;2;255;255;0mUP$escape[0m")
                    } else {
                        $null = $screen.Append("$escape[0;30m$escape[48;2;120;120;0mUP$escape[0m")
                    }
                } else {
                    $null = $screen.Append("$escape[0;30m$escape[48;2;255;255;0mUP$escape[0m")
                }
            } else {
                $null = $screen.Append("$escape[48;2;155;200;9m  $escape[0m")
            }
        }
        $null = $screen.AppendLine()
    }
    if(!$Padding) {
        $null = $screen.AppendLine("Score: $score")
    }
    [Console]::WriteLine($screen)
}

function Start-SoundProcessor {
    param (
        [System.Collections.Queue] $SoundQueue,
        [string] $Music
    )
    if($null -eq $script:Runspace) {
        $script:Runspace = [runspacefactory]::CreateRunspace()
        $script:Runspace.Open()
        $script:Runspace.SessionStateProxy.SetVariable('SoundQueue',$SoundQueue)
    }
    
    if($SoundQueue -and $null -eq $script:PowershellSounds) {
        $script:PowershellSounds = [powershell]::Create()
        $script:PowershellSounds.Runspace = $script:Runspace
        $script:PowershellSounds.AddScript({
            while($true) {
                if($SoundQueue.Count -gt 0) {
                    $sound = $SoundQueue.Dequeue()
                    [Console]::Beep($($sound.Frequency), $($sound.Duration))
                }
            }
        }) | Out-Null
        $script:SoundHandle = $script:PowershellSounds.BeginInvoke()
    }
    if($Music -and $null -eq $script:SoundPlayer) {
        $script:SoundPlayer = [System.Media.SoundPlayer]::new()
        $script:SoundPlayer.SoundLocation = $Music
        $script:SoundPlayer.PlayLooping()
    }
}

function Stop-SoundProcessor {
    try {
        $script:SoundPlayer.Stop()
        $script:SoundPlayer.Dispose()

        $script:PowershellSounds.Stop()
        $script:Runspace.Close()
        $script:PowershellSounds.Dispose()
    } catch {
        Write-Warning "Failed to shut down sound processor cleanly: $_"
    }
}