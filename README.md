# Export-VariableGroups PowerShell Script

This PowerShell script exports Azure DevOps variable groups to Azure Key Vault secrets. The script connects to your Azure DevOps organization, retrieves the specified variable groups, and exports the variables to the specified Key Vault.

## Prerequisites

- PowerShell 5.1 or later
- An Azure subscription with access to Azure DevOps and Azure Key Vault
- Permissions to manage Azure DevOps variable groups and Key Vault secrets

## Required Modules

The following PowerShell modules are required to run this script:

- Az
- AzDOps

## Installation Instructions

Follow these steps to ensure the required modules are installed and to run the script.

1. Open PowerShell with administrative privileges (Run as Administrator).

2. Install the Az module by running:
Install-Module -Name Az -Scope CurrentUser -AllowClobber -Force

3. Install the AzDOps module by running:
Install-Module -Name AzDOps -Scope CurrentUser -AllowClobber -Force


4. Close and reopen the PowerShell session.

## Running the Script

1. Navigate to the directory containing the `Export-VariableGroups.ps1` script.

2. Define the parameters for the script:

- `$organizationName`: The name of your Azure DevOps organization.
- `$projectName`: The name of your Azure DevOps project.
- `$variableGroupKeyVaultPairs`: An array of hashtables that define the variable group and Key Vault pairs. Each hashtable should include:
  - `variableGroup`: The name of the Azure DevOps variable group.
  - `keyVaultName`: The name of the Azure Key Vault where the secrets will be stored.

3. Run the script with the defined parameters:
.\Export-VariableGroups.ps1 -organizationName "<OrganizationName>" -projectName "<ProjectName>" -variableGroupKeyVaultPairs @( @{ variableGroup = "<VariableGroupName1>"; keyVaultName = "<KeyVaultName1>" }, @{ variableGroup = "<VariableGroupName2>"; keyvaultName = "<KeyVaultName2>" } )

Replace the placeholders with your actual values.

The script will connect to your Azure DevOps organization, retrieve the specified variable groups, and export the variables to the specified Key Vaults.
