#Requires -Version 7  -Modules PwshSpectreConsole

# a hella hack script to demonstrate terminal escape codes in PowerShell

Write-Host "`e[?1049h" -NoNewline # Switch to alternate buffer

function Clear-Line {
    $currentPosition = [Console]::GetCursorPosition()
    Write-Host ""
    Write-Host ($PSStyle.Reset + (" " * [Console]::BufferWidth)) -NoNewline
    [Console]::SetCursorPosition($currentPosition[0], $currentPosition[1])
}

try {
    while ($true) {
        [Console]::SetCursorPosition(0, 0)

        Write-Host ""
        Write-SpectreRule "PowerShell terminal escape code examples" -Color "Magenta2_1"
        Write-Host ""

        $magentaForeground = $PSStyle.Foreground.FromRgb(255, 0, 215)
        $greySlash = "[Grey30]/[/]"

        # Yeah this is hard to read. It's a mixture of spectre console and terminal escape codes because I wanted to put them in a table
        @(
            @{
                Code        = "[Magenta2_1]``a[/]"
                Description = "alert"
            },
            @{
                Code        = "[Magenta2_1]``e[[4m[/]"
                Description = "underline text"
            },
            @{
                Code        = "[Magenta2_1]``e[[0m[/]"
                Description = "reset text"
            },
            @{
                Code        = "[Magenta2_1]``e[[38;2;255;0;0m[/]"
                Description = "foreground rgb text"
            },
            @{
                Code        = "[Magenta2_1]``e[[48;2;0;155;0m[/]"
                Description = "background rgb text"
            },
            @{
                Code        = "[Magenta2_1]``e[[1A[/] $greySlash [Magenta2_1]``e[[1B[/] $greySlash [Magenta2_1]``e[[1C[/] $greySlash [Magenta2_1]``e[[1D[/]"
                Description = "move cursor 1 up / down / right / left"
            },
            @{
                Code        = "[Magenta2_1]``r[/]"
                Description = "move cursor to start of line"
            }
        ) | Format-SpectreTable -Property Code, Description -Width ([Console]::WindowWidth) -Border Rounded -Color Grey30 -HeaderColor Grey30 -AllowMarkup

        Clear-Line
        Write-Host "`e[?25h" -NoNewline # Enable cursor
        Write-Host "`n👉 Enter text to display or 'exit' to exit this script: $magentaForeground" -NoNewline
        $text = Read-Host

        # Disable cursor and clear below here
        Write-Host "`e[?25l`e[0J" -NoNewline

        Invoke-Expression "`$textInterpreted = `"$text`""
        Write-SpectreHost "`n[Magenta2_1]   Plain text: [/]" -NoNewline
        Write-Host $text
        Write-SpectreHost "[Magenta2_1]Terminal text: [/]" -NoNewline
        Write-Host $textInterpreted
        Write-Host $PSStyle.Reset -NoNewline

        if ($text -eq "exit") {
            break
        }
    }
}
finally {
    Write-Host "`e[?1049l" # Restore the original screen buffer
}