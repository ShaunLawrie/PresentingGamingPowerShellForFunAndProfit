# Super crappy way to write a nokia outline to the screen
function Write-Nokia {
  param (
    [int] $RenderLineDelayMilliseconds = 50,
    [switch] $NoStartup
  )
  $blue = "#424a6e"
  $darkBlue = "#2c3146"
  $grey = "#e7dfed"
  $darkGrey = "#b0b0b0"
  $darkerGrey = "#7f7f7f"
  $darkererGrey = "#4f4f4f"
  $offGreen = "#847236"
  $halfGreen = "#C6C651"
  $green = "#9bc809"
  if ($NoStartup) {
    $offGreen = $green
  }
  Write-SpectreHost " [$darkBlue]▟[/][$grey on $darkBlue]▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂[/][$darkBlue]▙[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$blue]▟[/][$grey on $blue]▞                      ▚[/][$blue]▙[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐           [black on $blue]●●●[/]          ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐                        ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black]         NOKIA        [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $offGreen]                    [/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $offGreen]                    [/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $offGreen]                    [/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $offGreen]                    [/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $offGreen]                    [/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $offGreen]                    [/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $offGreen]░░░░░░░░░░░░░░░░░░░░[/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $offGreen]▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒[/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $offGreen]▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $offGreen]▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [black on $blue]▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀[/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue] ▚[$grey on $blue]▃▂                  ▂▃[/]▞ [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]  ▜[$darkerGrey on $grey]  ▼  ▚  [blue on $grey]━━━━[/]  ▞  ▲  [/]▛  [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$darkGrey on $blue]    ▀▀▀▀▀[$darkererGrey on $blue]▀[/]▀▀▀▀▀▀[$darkererGrey on $blue]▀[/]▀▀▀▀▀    [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]                          [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]   [black on $darkGrey] [/][black on $grey] 1  [/]  [black on $grey]  2  [/]▌  [black on $grey]  3 [black on $darkGrey] [/][/]   [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]                          [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]   [black on $darkGrey] [/][black on $grey] 4  [/]  [black on $grey]  5  [/]▌  [black on $grey]  6 [black on $darkGrey] [/][/]   [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]                          [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]   [black on $darkGrey] [/][black on $grey] 7  [/]  [black on $grey]  8  [/]▌  [black on $grey]  9 [black on $darkGrey] [/][/]   [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]                          [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$darkBlue]▜[/][$darkBlue on $blue]▂[/][black on $blue]         ●●●          [/][$darkBlue on $blue]▂[/][$darkBlue]▛[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost " [$darkBlue]▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀[/]"

  if (!$NoStartup) {

    Start-Sleep -Milliseconds ($RenderLineDelayMilliseconds * 8)

    [Console]::CursorVisible = $false
    Write-Host "`r`e[23A" -NoNewline
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $halfGreen]                    [/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $halfGreen]                    [/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $halfGreen]                    [/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $halfGreen]                    [/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $halfGreen]                    [/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $halfGreen]                    [/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $halfGreen]░░░░░░░░░░░░░░░░░░░░[/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $halfGreen]▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒[/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $halfGreen]▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $halfGreen]▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[/] [/] ▌[/]"
    Start-Sleep -Milliseconds ($RenderLineDelayMilliseconds * 16)

    Write-Host "`r`e[10A" -NoNewline
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]                    [/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]                    [/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]                    [/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]                    [/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]                    [/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]                    [/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]░░░░░░░░░░░░░░░░░░░░[/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒[/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[/] [/] ▌[/]"
    Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[/] [/] ▌[/]"
    Start-Sleep -Milliseconds ($RenderLineDelayMilliseconds * 5)

    Write-Host "`e[6A`e[11C" -NoNewline
    @("N", "O", "K", "I", "A") | ForEach-Object {
      Write-Host -ForegroundColor "Black" "$($PSStyle.Background.FromRgb(155, 200, 9))$_$($PSStyle.Reset)" -NoNewline
      Start-Sleep -Milliseconds ($RenderLineDelayMilliseconds * 2)
    }

    $soundPlayer = [System.Media.SoundPlayer]::new()
    $soundPlayer.SoundLocation = (Resolve-Path "$PSScriptRoot\resources\nokia_startup_tone.wav").Path
    $soundPlayer.PlaySync()
    $soundPlayer.Dispose()
  }
  else {
    [Console]::CursorVisible = $true
  }
}
