#!/usr/bin/env pwsh

param (
    [int] $Width = 10,
    [int] $Height = 10
)

Import-Module ./SnakeModule.psm1 -Force

$food = Get-RandomFood -Width $Width -Height $Height
$snake = @( @{ X = 5; Y = 5; } )
$direction = "RightArrow"
$score = 0

while($true) {
    $direction = Read-Direction -Direction $direction
    $snake = Move-Snake -Snake $snake -Direction $direction -Width $Width -Height $Height

    if(Test-Collision -ObjectToTest $snake[1..($snake.Length - 1)] -PositionX $snake[0].X -PositionY $snake[0].Y) {
        break
    }

    if(Test-Collision -ObjectToTest $snake -PositionX $food.X -PositionY $food.Y) {
        $food = Get-RandomFood -Width $Width -Height $Height
        $score++
    } else {
        $snake = Remove-SnakeTail -Snake $snake
    }

    Write-GameBoard -Width $Width -Height $Height -Snake $snake -Food $food
    Start-Sleep -Milliseconds 100
}

Write-Host "Game Over! Your score was $score`e[0J"

$bodyJson = @{
    Name = $env:USERNAME
    Value = $score
} | ConvertTo-Json -Compress

Invoke-RestMethod -Uri "http://localhost:5187/scores" -Method "Post" -ContentType "application/json" -Body $bodyJson

$scores = Invoke-RestMethod -Uri "http://localhost:5187/scores"
$scores | Out-Host

