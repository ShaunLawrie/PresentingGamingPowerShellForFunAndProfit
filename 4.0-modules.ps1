param (
    [int] $Width = 10,
    [int] $Height = 10
)

Import-Module -Name "./4.1-modules.psm1" -Force

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
    Invoke-GameRender -Width $Width -Height $Height -Snake $snake -Food $food
    Start-Sleep -Seconds 1
}