function Test-Collision {
    param (
        [object] $ObjectToTest,
        [int] $CurrentPositionX,
        [int] $CurrentPositionY
    )

    if($ObjectToTest -is [array]) {
        foreach($item in $ObjectToTest) {
            if(Test-Collision -ObjectToTest $item -CurrentPositionX $CurrentPositionX -CurrentPositionY $CurrentPositionY) {
                return $true
            }
        }
    }
    
    if($CurrentPositionX -eq $ObjectToTest.X -and $CurrentPositionY -eq $ObjectToTest.Y) {
        return $true
    }

    return $false
}

function Invoke-GameRender {
    param (
        [int] $Height,
        [int] $Width,
        [array] $Snake,
        [hashtable] $Food
    )

    for($row = 0; $row -lt $Height; $row++) {
        for($col = 0; $col -lt $Width; $col++) {
            if(Test-Collision -ObjectToTest $snake -CurrentPositionX $col -CurrentPositionY $row) {
                Write-Host -BackgroundColor Green "  " -NoNewline
            } elseif(Test-Collision -ObjectToTest $food -CurrentPositionX $col -CurrentPositionY $row) {
                Write-Host -BackgroundColor Red "  " -NoNewline
            } else {
                Write-Host -BackgroundColor Gray "  " -NoNewline
            }
        }
        Write-Host "" # Just writing a newline
    }
    Write-Host -NoNewline "`r`e[${Height}A" # Move the cursor back to the top
}

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

function Move-Snake {
    param (
        [array] $Snake,
        [string] $Direction,
        [int] $Width,
        [int] $Height
    )

    $head = $Snake[0].Clone()

    switch ($Direction) {
        "Up"    { $head.Y-- }
        "Down"  { $head.Y++ }
        "Left"  { $head.X-- }
        "Right" { $head.X++ }
    }

    # wrap around the terminal
    if($head.X -lt 0) {
        $head.X = $Width - 1
    } elseif($head.X -ge $Width) {
        $head.X = 0
    }
    if($head.Y -lt 0) {
        $head.Y = $Height - 1
    } elseif($head.Y -ge $Height) {
        $head.Y = 0
    }
    
    return $head, $Snake
}