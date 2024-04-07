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
    while($true) {
        [Console]::SetCursorPosition(0, 0)

        Write-Host ""
        Write-SpectreRule "PowerShell terminal escape code examples" -Color "Purple_2"
        Write-Host ""

        $magentaForeground = $PSStyle.Foreground.FromRgb(175, 0, 255)
        $greySlash = "[Grey30]/[/]"

        # Yeah this is hard to read. It's a mixture of spectre console and terminal escape codes because I wanted to put them in a table
        @(
            @{
                Code = "[Purple_2]``a[/]"
                Description = "alert"
            },
            @{
                Code = "[Purple_2]``e[[4m[/]"
                Description = "underline text"
            },
            @{
                Code = "[Purple_2]``e[[0m[/]"
                Description = "reset text"
            },
            @{
                Code = "[Purple_2]``e[[38;2;255;0;0m[/]"
                Description = "foreground rgb text"
            },
            @{
                Code = "[Purple_2]``e[[48;2;0;155;0m[/]"
                Description = "background rgb text"
            },
            @{
                Code = "[Purple_2]``e[[1A[/] $greySlash [Purple_2]``e[[1B[/] $greySlash [Purple_2]``e[[1C[/] $greySlash [Purple_2]``e[[1D[/]"
                Description = "move cursor 1 up / down / right / left"
            },
            @{
                Code = "[Purple_2]``r[/]"
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
        Write-SpectreHost "`n[Purple_2]   Plain text: [/]" -NoNewline
        Write-Host $text
        Write-SpectreHost "[Purple_2]Terminal text: [/]" -NoNewline
        Write-Host $textInterpreted
        Write-Host $PSStyle.Reset -NoNewline

        if($text -eq "exit") {
            break
        }
    }
} finally {
    Write-Host "`e[?1049l" # Restore the original screen buffer
}