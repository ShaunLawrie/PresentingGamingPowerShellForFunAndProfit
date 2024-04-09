function New-RandomItem {
    param (
        [int] $Width,
        [int] $Height
    )

    return @{
        X = Get-Random -Minimum 0 -Maximum $Width
        Y = Get-Random -Minimum 0 -Maximum $Height
    }
}

function Test-Collision {
    param (
        [object] $ObjectToTest,
        [hashtable] $Position
    )

    if($ObjectToTest -is [array]) {
        foreach($item in $ObjectToTest) {
            if($item.X -eq $Position.X -and $item.Y -eq $Position.Y) {
                return $true
            }
        }
    } elseif($ObjectToTest.X -eq $Position.X -and $ObjectToTest.Y -eq $Position.Y) {
        return $true
    }
    
    return $false
}

function Write-GameBoard {
    param (
        [int] $Width,
        [int] $Height,
        [array] $Snake,
        [hashtable] $Food
    )
    for($row = 0; $row -lt $Height; $row++) {
        for($col = 0; $col -lt $Width; $col++) {
            if(Test-Collision -ObjectToTest $Snake -Position @{ X = $col; Y = $row }) {
                Write-Host -NoNewline -BackgroundColor DarkGreen "  "
            }  elseif (Test-Collision -ObjectToTest $Food -Position @{ X = $col; Y = $row }) {
                Write-Host -NoNewline -BackgroundColor DarkRed "  "
            }
            else {
                Write-Host -NoNewline -BackgroundColor DarkBlue "  "
            }
        }
        Write-Host
    }
    Write-Host "`e[${Height}A" -NoNewline
}

function Move-Snake {
    param (
        [array] $Snake,
        [string] $Direction,
        [int] $Width,
        [int] $Height
    )

    $newHead = $Snake[0].Clone()
    switch($Direction) {
        "Up" { $newHead.Y-- }
        "Down" { $newHead.Y++ }
        "Left" { $newHead.X-- }
        "Right" { $newHead.X++ }
    }

    # wrap around the terminal
    if($newHead.X -lt 0) { $newHead.X = $Width - 1 }
    if($newHead.X -ge $Width) { $newHead.X = 0 }
    if($newHead.Y -lt 0) { $newHead.Y = $Height - 1 }
    if($newHead.Y -ge $Height) { $newHead.Y = 0 }

    return @($newHead) + $Snake
}

function Read-Direction {
    param (
        [string] $Direction
    )

    # Read-Host -Prompt "Enter direction (Up, Down, Left, Right)"

    if([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true)
        switch($key.Key) {
            "UpArrow" { return "Up" }
            "DownArrow" { return "Down" }
            "LeftArrow" { return "Left" }
            "RightArrow" { return "Right" }
        }
    }

    return $Direction
}

function Remove-SnakeTail {
    param (
        [array] $Snake
    )

    return $Snake[0..($Snake.Length - 2)]
}