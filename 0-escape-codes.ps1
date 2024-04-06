Clear-Host

function Clear-Line {
    param (
        [switch] $All
    )
    $currentPosition = [Console]::GetCursorPosition()
    if($All) {
        Write-Host (" " * ([Console]::WindowWidth * [Console]::WindowHeight - 1)) -NoNewline
    } else {
        Write-Host (" " * [Console]::BufferWidth) -NoNewline
    }
    [Console]::SetCursorPosition($currentPosition[0], $currentPosition[1])
}

try {
    while($true) {
        [Console]::SetCursorPosition(0, 0)
        Clear-Line
        Write-Host -ForegroundColor Magenta "Enter text to display or 'exit' to exit this script: " -NoNewline
        $text = Read-Host
        Invoke-Expression "`$textInterpreted = `"$text`""

        Clear-Line -All
        Write-Host -ForegroundColor DarkGray "   Plain text: " -NoNewline
        Write-Host $text
        Write-Host -ForegroundColor DarkGray "Terminal text: " -NoNewline
        Write-Host $textInterpreted

        if($text -eq "exit") {
            break
        }
    }
} finally {
    Clear-Host
}