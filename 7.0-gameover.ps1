param (
    [int] $Width = 10,
    [int] $Height = 10
)

Import-Module -Name "./4.1-modules.psm1" -Force
Import-Module -Name "./5.1-modules.psm1" -Force
Import-Module -Name "./6.1-modules.psm1" -Force

$score = 0
$direction = "Right"
$food = New-Food -Width $Width -Height $Height
$snake = @(
    @{
        X = 5
        Y = 5
    }
)

while($true) {
    $snake = Move-Snake -Snake $snake -Direction $direction -Width $Width -Height $Height
    
    # Game over
    if(Test-Collision -ObjectToTest $snake[1..($snake.Count)] -CurrentPositionX $snake[0].X -CurrentPositionY $snake[0].Y) {
        break
    }

    if(Test-Collision -ObjectToTest $snake -CurrentPositionX $food.X -CurrentPositionY $food.Y) {
        $food = New-Food -Width $Width -Height $Height
        $score++
    } else {
        $snake = Remove-Tail -Snake $snake
    }
    Invoke-GameRender -Width $Width -Height $Height -Snake $snake -Food $food -Score $score
    Start-Sleep -Milliseconds 500
    $direction = Get-Direction -CurrentDirection $direction
}

Write-Host "Game Over! Your score was $score`e[0J"

# Save score
$record = @{
    Name = $env:USERNAME
    Value = $score
}
$recordJson = $record | ConvertTo-Json
Invoke-RestMethod `
    -Uri "http://localhost:5187/scores" `
    -Method "POST" `
    -Headers @{ "Content-Type" = "application/json" } `
    -Body $recordJson | Out-Null

# Get scores
Invoke-RestMethod -Uri "http://localhost:5187/scores" -Method Get
