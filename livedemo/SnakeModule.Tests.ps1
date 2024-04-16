# Import the module to be tested
Import-Module ./SnakeModule.psm1 -Force

Describe "SnakeModule" {
    Context "Get-RandomFood" {
        It "Returns a hashtable with X and Y coordinates" {
            $food = Get-RandomFood -Width 10 -Height 10
            $food.Keys -contains "X" | Should -Be $true
            $food.Keys -contains "Y" | Should -Be $true
        }

        It "Returns coordinates within the specified range" {
            $width = 10
            $height = 10
            $food = Get-RandomFood -Width $width -Height $height
            $food.X | Should -BeLessThan $width
            $food.Y | Should -BeLessThan $height
        }
    }

    Context "Write-GameBoard" {
        It "Does not throw an error with valid parameters" {
            $snake = @(
                @{ X = 1; Y = 1 },
                @{ X = 2; Y = 2 },
                @{ X = 3; Y = 3 }
            )
            $food = @{ X = 5; Y = 5 }
            { Write-GameBoard -Width 10 -Height 10 -Snake $snake -Food $food } | Should -Not -Throw
        }
    }
}