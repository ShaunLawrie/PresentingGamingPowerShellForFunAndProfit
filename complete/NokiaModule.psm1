# Super crappy way to write a nokia outline to the screen
function Write-Nokia {
  param (
    [int] $RenderLineDelayMilliseconds = 50,
    [switch] $NoStartup
  )
  $blue = "#424a6e"
  $grey = "#e7dfed"
  $green = "#9bc809"
  Write-SpectreHost " [$blue]▟[/][$grey on $blue]▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂[/][$blue]▙[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$blue]▟[/][$grey on $blue]▞                      ▚[/][$blue]▙[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐           [black on $blue]●●●[/]          ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐                        ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black]         NOKIA        [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]                    [/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]                    [/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]                    [/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]                    [/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]                    [/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]                    [/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]░░░░░░░░░░░░░░░░░░░░[/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒[/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [$grey on black] [black on $green]▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[/] [/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]▐ [black on $blue]▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀[/] ▌[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue] ▚[$grey on $blue]▃▂                  ▂▃[/]▞ [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]  ▜[blue on $grey]        ━━━━        [/]▛  [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]    ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀    [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]                          [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]   [black on $grey]  1  [/]  [black on $grey]  2  [/]▌  [black on $grey]  3  [/]   [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]                          [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]   [black on $grey]  4  [/]  [black on $grey]  5  [/]▌  [black on $grey]  6  [/]   [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]                          [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]   [black on $grey]  7  [/]  [black on $grey]  8  [/]▌  [black on $grey]  9  [/]   [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$grey on $blue]                          [/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost "[$blue]▜[/][black on $blue]          ●●●           [/][$blue]▛[/]"
  Start-Sleep -Milliseconds $RenderLineDelayMilliseconds
  Write-SpectreHost " [$blue]▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀[/]"

  if(!$NoStartup) {
    Write-Host "`e[19A`e[11C" -NoNewline
    @("N", "O", "K", "I", "A") | ForEach-Object {
      Write-Host -ForegroundColor "Black" "$($PSStyle.Background.FromRgb(155, 200, 9))$_$($PSStyle.Reset)" -NoNewline
      Start-Sleep -Milliseconds ($RenderLineDelayMilliseconds * 2)
    }

    $soundPlayer = [System.Media.SoundPlayer]::new()
    $soundPlayer.SoundLocation = (Resolve-Path "$PSScriptRoot\resources\nokia_startup_tone.wav").Path
    $soundPlayer.PlaySync()
    $soundPlayer.Dispose()
  }
}
