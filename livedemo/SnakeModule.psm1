function Get-RandomFood {
    param (
        [int] $Width,
        [int] $Height
    )

    $food = @{
        X = Get-Random -Minimum 0 -Maximum $Width
        Y = Get-Random -Minimum 0 -Maximum $Height
    }

    return $food
}

function Write-GameBoard {
  param (
    [int] $Width,
    [int] $Height,
    [array] $Snake,
    [hashtable] $Food
  )

  [Console]::CursorVisible = $false
  for($row = 0; $row -lt $Height; $row++) {
    for($col = 0; $col -lt $Width; $col++) {
        # Check for collisions
        if(Test-Collision -ObjectToTest $Snake -PositionX $col -PositionY $row) {
            Write-Host -NoNewline -BackgroundColor "DarkGreen" -Message "  "
        } elseif(Test-Collision -ObjectToTest $Food -PositionX $col -PositionY $row) {
            Write-Host -NoNewline -BackgroundColor "DarkRed" -Message "  "
        } else {
            Write-Host -NoNewline -BackgroundColor "DarkBlue" -Message "  "
        }
    }
    Write-Host ""
  }

  Write-Host "`r`e[${Height}A" -NoNewline
}

function Test-Collision {
    param (
        [object] $ObjectToTest,
        [int] $PositionX,
        [int] $PositionY
    )

    if($ObjectToTest -is [array]) {
      foreach($object in $ObjectToTest) {
        if($object.X -eq $PositionX -and $object.Y -eq $PositionY) {
            return $true
        }
      }
    } else {
      if($ObjectToTest.X -eq $PositionX -and $ObjectToTest.Y -eq $PositionY) {
        return $true
      }
    }

    return $false
}

function Move-Snake {
  param (
    [array] $Snake,
    [string] $Direction,
    [int] $Width,
    [int] $Height
  )

  $head = $Snake[0].Clone()

  switch($Direction) {
    "UpArrow" {
      $head.Y--
    }
    "DownArrow" {
      $head.Y++
    }
    "LeftArrow" {
      $head.X--
    }
    "RightArrow" {
      $head.X++
    }
  }

  # wrap around please
  if($head.X -lt 0) {
    $head.X = $Width - 1
  } elseif($head.X -ge $Width) {
    $head.X = 0
  }
  if($head.Y -lt 0) {
    $head.Y = $Height - 1
  } elseif($head.Y -ge $Height) {
    $head.Y = 0
  }

  return @($head) + $Snake
}

function Read-Direction {
  param (
    [string] $Direction
  )
  
  $validDirections = @("UpArrow", "DownArrow", "LeftArrow", "RightArrow")

  if([Console]::KeyAvailable) {
    $newDirection = [Console]::ReadKey($true)

    if($validDirections -contains $newDirection.Key) {
      return $newDirection.Key
    }
  }

  return $Direction
}

function Remove-SnakeTail {
  param (
    [array] $Snake
  )

  return $Snake[0..($Snake.Length - 2)]
}