# Define the input message (the string to be reversed)
# In this case, we're using "Hello, Powershell!"
$inputMessage = "Hello, Powershell!"

# Convert the string into an array of individual characters
# Example: "Hello" → ['H', 'e', 'l', 'l', 'o']
# This allows us to manipulate or reorder the characters.
$charArray = $inputMessage.ToCharArray()

# Create a reversed sequence using negative indexing
# [-1..-($inputMessage.Length)] starts at the last character (-1)
# and counts backward until it reaches the first character (-Length).
# Example: ['H', 'e', 'l', 'l', 'o'] → ['o', 'l', 'l', 'e', 'H']
$reversedChars = $charArray[-1..-($inputMessage.Length)]

# Join the reversed character array back into a single string
# Without -join, the output would still be an array of characters.
$reversedMessage = -join $reversedChars

# Display the final reversed string to the user
# Example output: "!llehsrewoP ,olleH"
Write-Host "Reversed: $reversedMessage"
