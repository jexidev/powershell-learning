# Learning write statements

Write-Host "I am learning how to display messages to the user"

# Mainly used to outputting informational text

write-host "Outputs can be formatted with background and foreground colours" -ForegroundColor Blue -BackgroundColor Yellow

# Write output

write-output "Write-Output is another way of displaying user messages, but it's designed to work with the pipeline"

# Echo is shorthand for write-output

echo "Echo is the same as write-output"

# This is how to use variables!

$name = "JexiDev" 
Write-Host "My name is $name"

# Interpreting strings with interpolation

$num1 = 10
$num2 = 20
Write-Host "The sum of $num1 and $num2 is $(($num1 + $num2))"

# Concatenate different variables and strings

$greeting = "Hello"

Write-Host "$greeting, $name! Welcome to PowerShell"



Read-Host "Press Enter to Exit"