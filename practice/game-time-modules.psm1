function New-Food {
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
        [hashtable] $CurrentPosition
    )

    if($ObjectToTest -is [array]) {
        foreach($item in $ObjectToTest) {
            if(Test-Collision -ObjectToTest $item -CurrentPosition $CurrentPosition) {
                return $true
            }
        }
    } else {
        if($ObjectToTest.X -eq $CurrentPosition.X -and $ObjectToTest.Y -eq $CurrentPosition.Y) {
            return $true
        }
    }
    
    return $false
}

function Write-GameBoard {
    param (
        [array] $Snake,
        [hashtable] $Food,
        [int] $Width,
        [int] $Height
    )
    for($row = 0; $row -lt $Height; $row++) {
        for($col = 0; $col -lt $Width; $col++) {
            if(Test-Collision -ObjectToTest $Snake -CurrentPosition @{ X = $col; Y = $row }) {
                Write-Host -NoNewline -BackgroundColor DarkGreen ('  ')
            } elseif(Test-Collision -ObjectToTest $Food -CurrentPosition @{ X = $col; Y = $row }) {
                Write-Host -NoNewline -BackgroundColor DarkRed ('  ')
            } else {
                Write-Host -NoNewline -BackgroundColor DarkBlue ('  ')
            }
        }
        Write-Host "" # Just a new line
    }
    Write-Host "`r`e[${Height}A" -NoNewline # Move the cursor back to the start of the line and top of the board
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
        'Up' { $newHead.Y-- }
        'Down' { $newHead.Y++ }
        'Left' { $newHead.X-- }
        'Right' { $newHead.X++ }
    }

    # handle wrapping
    if($newHead.X -lt 0) { $newHead.X = $Width - 1 }
    if($newHead.X -ge $Width) { $newHead.X = 0 }
    if($newHead.Y -lt 0) { $newHead.Y = $Height - 1 }
    if($newHead.Y -ge $Height) { $newHead.Y = 0 }

    return @($newHead) + $Snake
}

function Remove-SnakeTail {
    param (
        [array] $Snake
    )
    return $Snake[0..($Snake.Count - 2)]
}

function Read-Direction {
    param (
        [string] $Direction
    )

    if([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true).Key
        switch($key) {
            'LeftArrow' { return 'Left' }
            'RightArrow' { return 'Right' }
            'UpArrow' { return 'Up' }
            'DownArrow' { return 'Down' }
        }
    }

    return $Direction
}