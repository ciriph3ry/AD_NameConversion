{
		# Prompt for user input
		$namesInput = Read-Host "Enter a list of first and last names separated by commas (e.g., John Doe, Jane Smith):`n"

		# Split the input into an array of names
		$names = $namesInput -split ',' | ForEach-Object { $_.Trim() }

		# Iterate through each name and retrieve corresponding samAccountName
		foreach ($name in $names) {
			# Split the name into first and last parts
			$nameParts = $name -split ' '
    
			if ($nameParts.Count -eq 2) {
				$firstName = $nameParts[0]
				$lastName = $nameParts[1]
        
				# Search for the user by first and last name in Active Directory
				$user = Get-ADUser -Filter {GivenName -eq $firstName -and Surname -eq $lastName -and SamAccountName -notlike '*A' -and SamAccountName -notlike '*W' -and SamAccountName -notlike '*S'} -Properties samAccountName
        
				if ($user) {
					$samAccountName = $user.samAccountName
					Write-Host "$samAccountName"
				} else {
					Write-Host "User with first name '$firstName' and last name '$lastName' not found."
				}
			} else {
				Write-Host "Invalid name format: $name"
				}
			}
			Read-Host -prompt "`nPress Any Key To Return To Exit"
	}
