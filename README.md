Export-VariableGroups PowerShell Script
This PowerShell script exports Azure DevOps variable groups to Azure Key Vault secrets. The script connects to your Azure DevOps organization, retrieves the specified variable groups, and exports the variables to the specified Key Vault.

Prerequisites

PowerShell 5.1 or later
An Azure subscription with access to Azure DevOps and Azure Key Vault
Permissions to manage Azure DevOps variable groups and Key Vault secrets
Required Modules
The following PowerShell modules are required to run this script:

Az
Installation Instructions

Open PowerShell with administrative privileges (Run as Administrator).
Install the Az module by running:
powershell
Copy code
Install-Module -Name Az -Scope CurrentUser -AllowClobber -Force
Close and reopen the PowerShell session.
Create a Personal Access Token (PAT) with the minimum required permissions

Go to your Azure DevOps organization settings.
Click on "Personal access tokens" under the "Security" section.
Click "New Token" to create a new token.
Give the token a name and select an expiration date.
Under "Scopes," grant the following permissions:
Project and Team: Read
Variable Groups: Read & Manage
Click "Create" to generate the token.
Running the Script

Navigate to the directory containing the Export-VariableGroups.ps1 script.
Define the parameters for the script:
$organizationName: The name of your Azure DevOps organization.
$projectName: The name of your Azure DevOps project.
$PAT: The Personal Access Token you created earlier.
$variableGroupKeyVaultPairs: An array of hashtables that define the variable group and Key Vault pairs. Each hashtable should include:
variableGroup: The name of the Azure DevOps variable group.
keyVaultName: The name of the Azure Key Vault where the secrets will be stored.
Run the script with the defined parameters:
powershell
Copy code
.\Export-VariableGroups.ps1 -OrganizationName "<OrganizationName>" -ProjectName "<ProjectName>" -PAT "<PAT>" -VariableGroupKeyVaultPairs @( @{ Name = "<VariableGroupName1>"; Value = "<KeyVaultName1>" }, @{ Name = "<VariableGroupName2>"; Value = "<KeyVaultName2>" } )
Replace the placeholders with your actual values.

The script will connect to your Azure DevOps organization, retrieve the specified variable groups, and export the variables to the specified Key Vaults.