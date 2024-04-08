$string = "hello"
$int = 5
$array = @("hello", "world")
$hashtable = @{
    X = 1
    Y = 2
}

$hashtable["ItemName"] = 123

Write-Host "Array is $($array -join ', ')"

return $hashtable