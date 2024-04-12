
# Snake game in PowerShell written a while ago that works but is a bit janky
param (
    [int] $GameWidth = 10,
    [int] $GameHeight = 10,
    [int] $TargetFps = 8,
    [int] $PowerUpIntervalSeconds = 20,
    [int] $PoweredUpIntervalSeconds = 10,
    [bool] $RenderInNokia = $true
)

$ErrorActionPreference = "Stop"

Import-Module "$PSScriptRoot/SnakeModule.psm1" -Force
Import-Module "$PSScriptRoot/NokiaModule.psm1" -Force

# global variable
$global:gameWidth = $GameWidth
$global:gameHeight = $GameHeight
$global:snake = @( @{ X = $global:GameWidth / 2; Y = $global:GameWidth / 2 } )
$global:frameCount = 1

# local variables
$directions = @("UpArrow", "DownArrow", "LeftArrow", "RightArrow")
$snakeDirection = $directions[(Get-Random -Minimum 0 -Maximum 4)]
$targetDirection = $snakeDirection
$score = 0
$food = New-Food
$powerUp = $null
$poweredUp = 0

# generate a powerup every x seconds
$powerUpInterval = $PowerUpIntervalSeconds * $TargetFps
$powerUpLifetime = $powerUpInterval / 2
$poweredUpLifetime = $PoweredUpIntervalSeconds * $TargetFps

# render pacing
$targetLoopDurationMilliseconds = 1000 / $TargetFps
$lastRender = (Get-Date).AddSeconds(-10)

# sound effects background thread
$soundQueue = [System.Collections.Queue]::Synchronized([System.Collections.Queue]::new())
Start-SoundProcessor -SoundQueue $soundQueue -Music (Resolve-Path "$PSScriptRoot\resources\oldsongfromuni.wav").Path

Clear-Host
[Console]::CursorVisible = $false

# Rendering hacks for the nokia outline
$gamePadding = 0
$gameTop = 0
if ($RenderInNokia) {
    if ($GameWidth -ne 10 -or $GameHeight -ne 10) {
        throw "Game width and height must be 10 to render inside the crappy nokia outline"
    }
    Write-Nokia
    $gameTop = 5
    $gamePadding = 3
}

try {
    $timing = Measure-Command {
        while (!$gameOver) {
            $key = Get-LastKeyPressed
            if ($key.Key -eq "Q") {
                $gameOver = $true
            }
            if (Test-DirectionAllowed -CurrentDirection $snakeDirection -NewDirection $key.Key -Directions $directions) {
                $targetDirection = $key.Key
            }

            $sinceLastRender = New-TimeSpan -Start $lastRender -End (Get-Date)
            if ($sinceLastRender.TotalMilliseconds -ge $targetLoopDurationMilliseconds) {
                $lastRender = Get-Date

                $powerUp = Update-PowerUp -PowerUp $powerUp -PowerUpInterval $powerUpInterval -PowerUpLifetime $powerUpLifetime
                if ($poweredUp -gt 0) {
                    $poweredUp--
                }

                $snakeDirection = Add-SnakeHead -Direction $targetDirection
                
                $latestPosition = $global:snake[$global:snake.Count - 1]
                if (Test-IsSnake -Position $latestPosition -ExcludeHead -PoweredUp $poweredUp) {
                    $soundQueue.Enqueue(@{ Frequency = 900; Duration = 250 })
                    $soundQueue.Enqueue(@{ Frequency = 800; Duration = 100 })
                    $soundQueue.Enqueue(@{ Frequency = 700; Duration = 100 })
                    $soundQueue.Enqueue(@{ Frequency = 100; Duration = 500 })
                    Start-Sleep -Seconds 2
                    $gameOver = $true
                }
                elseif (Test-IsFood -Position $latestPosition -Food $food) {
                    $soundQueue.Enqueue(@{ Frequency = 400; Duration = 100 })
                    $food = New-Food
                    $score++
                }
                elseif (Test-IsPowerUp -Position $latestPosition -PowerUp $powerUp) {
                    $soundQueue.Enqueue(@{ Frequency = 600; Duration = 100 })
                    $soundQueue.Enqueue(@{ Frequency = 800; Duration = 200 })
                    $powerUp = $null
                    $poweredUp = $poweredUpLifetime
                    $score += 10
                }
                else {
                    Remove-SnakeTail
                }

                [Console]::SetCursorPosition(0, $gameTop)
                Write-GameGrid -Score $score -Food $food -PowerUp $powerUp -PoweredUp $poweredUp -PowerUpLifetime $powerUpLifetime -PoweredUpLifetime $poweredUpLifetime -Padding $gamePadding
                $global:frameCount++
            }
        }
        if ($RenderInNokia) {
            [Console]::SetCursorPosition(0, 0)
            Write-Nokia -NoStartup
            $currentPosition = [Console]::GetCursorPosition()
            Write-Host "`e[19A`e[9C" -NoNewline
            Write-Host -ForegroundColor "Black" "$($PSStyle.Background.FromRgb(155, 200, 9))Score: $score$($PSStyle.Reset)" -NoNewline
            [Console]::SetCursorPosition($currentPosition[0], $currentPosition[1])
        }
        else {
            Write-Host "Game over, score was: $score"
        }
        [Console]::CursorVisible = $true
    }
}
finally {
    Stop-SoundProcessor
}