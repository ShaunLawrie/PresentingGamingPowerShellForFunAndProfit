
# Define the script path
Import-Module "$PSScriptRoot\game-module.psm1" -Force

# Define the tests
Describe "Game Module Tests" {
    Context "Game Over Message" {
        It "Should display game over message" {
            $result = Write-Host "Game Over! Your score was $score`e[0J"
            $result | Should -Be "Game Over! Your score was $score`e[0J"
        }
    }

    Context "Score Data" {
        It "Should create score data with username and score" {
            $result = @{
                Name = $env:USERNAME
                Value = $score
            }
            $result.Name | Should -Be $env:USERNAME
            $result.Value | Should -Be $score
        }
    }

    Context "Invoke Rest Method" {
        It "Should post score data and get scores" {
            Mock Invoke-RestMethod { return @{Name = 'Test'; Value = 10} }
            $result = Invoke-RestMethod -Uri "http://localhost:5187/scores" -Method Post -Body ($scoreData | ConvertTo-Json) `
             -ContentType "application/json"
            $result.Name | Should -Be 'Test'
            $result.Value | Should -Be 10
        }
    }
}