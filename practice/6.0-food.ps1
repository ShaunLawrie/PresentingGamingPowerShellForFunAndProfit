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