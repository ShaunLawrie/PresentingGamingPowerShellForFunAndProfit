param (
    [int] $Width = 10,
    [int] $Height = 10
)

$food = @{
    X = 7
    Y = 5
}
$snake = @(
    @{
        X = 5
        Y = 5
    }
)

for($row = 0; $row -lt $Height; $row++) {
    for($col = 0; $col -lt $Width; $col++) {
        if($snake[0].X -eq $col -and $snake[0].Y -eq $row) {
            Write-Host -BackgroundColor Green "  " -NoNewline
        } elseif($food.X -eq $col -and $food.Y -eq $row) {
            Write-Host -BackgroundColor Red "  " -NoNewline
        } else {
            Write-Host -BackgroundColor Gray "  " -NoNewline
        }
    }
    Write-Host "" # Just writing a newline
}