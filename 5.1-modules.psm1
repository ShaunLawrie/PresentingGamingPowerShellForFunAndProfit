function Get-Direction {
    param (
        [string] $CurrentDirection
    )

    if(![Console]::KeyAvailable) {
        return $CurrentDirection
    }

    $direction = [Console]::ReadKey($true).Key.ToString()
    switch($direction) {
        "UpArrow" {
            return "Up"
        }
        "DownArrow" {
            return "Down"
        }
        "LeftArrow" {
            return "Left"
        }
        "RightArrow" {
            return "Right"
        }
        default {
            return $CurrentDirection
        }
    }
}