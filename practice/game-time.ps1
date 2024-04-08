param (
    [int] $Height = 10,
    [int] $Width = 10
)

# functions
Import-Module -Name "$PSScriptRoot/game-time-modules.psm1" -Force

# game objects
$food = New-Food -Width $Width -Height $Height
$direction = 'Right'
$score = 0
$snake = @( @{ X = 5; Y = 5 } )

# game
[Console]::CursorVisible = $false
while($true) {
    $snake = Move-Snake -Snake $snake -Direction $direction -Width $Width -Height $Height

    if(Test-Collision -ObjectToTest $snake[1..($snake.Count)] -CurrentPosition $snake[0]) {
        break
    }

    if(Test-Collision -ObjectToTest $snake[0] -CurrentPosition $food) {
        $food = New-Food -Width $Width -Height $Height
        $score++
    } else {
        $snake = Remove-SnakeTail -Snake $snake
    }

    Write-GameBoard -Snake $snake -Food $food -Width $Width -Height $Height
    Start-Sleep -Milliseconds 200
    $direction = Read-Direction -Direction $direction
}
[Console]::CursorVisible = $true
Write-Host "Game Over! Your score was $score`e[0J"

Invoke-RestMethod `
    -Uri "http://localhost:5187/scores" `
    -Method Post `
    -ContentType "application/json" `
    -Body (@{
        Name = $env:USERNAME
        Value = $score
    } | ConvertTo-Json)

$scores = Invoke-RestMethod "http://localhost:5187/scores"
$scores | Out-Host