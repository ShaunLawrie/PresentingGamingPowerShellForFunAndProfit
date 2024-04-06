function Remove-Tail {
    param (
        [array] $Snake
    )

    return $snake[0..($snake.Count - 2)]
}

function Invoke-GameRender {
    param (
        [int] $Height,
        [int] $Width,
        [array] $Snake,
        [hashtable] $Food,
        [int] $Score
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
    Write-Host -NoNewline "Score: $score`r`e[${Height}A" # Move the cursor back to the top
}