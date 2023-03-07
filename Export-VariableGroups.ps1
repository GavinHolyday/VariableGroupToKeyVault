param(
    [string]$organizationName,
    [string]$projectName,
    [hashtable[]]$variableGroupKeyVaultPairs
)

# Connect to Azure DevOps
Connect-AzAccount
$project = Get-AzDevOpsProject -OrganizationName $organizationName -ProjectName $projectName

# Loop through each variable group - Key Vault pair
foreach ($pair in $variableGroupKeyVaultPairs) {
    # Get the variable group
    $variableGroup = Get-AzDoVariableGroup -Name $pair.variableGroup -Project $project.Name

    # Get the Key Vault
    $keyVault = Get-AzKeyVault -VaultName $pair.keyVaultName -ResourceGroupName $pair.keyVaultResourceGroupName

    # Export the variables to the Key Vault
    $variables = Get-AzDoVariable -VariableGroup $variableGroup -Project $project.Name
    foreach ($variable in $variables) {
        $secretName = "$($variableGroup.Name)-$($variable.Name)"
        $secretValue = ConvertTo-SecureString $variable.Value -AsPlainText -Force
        Set-AzKeyVaultSecret -VaultName $keyVault.Name -Name $secretName -SecretValue $secretValue
    }
}

# Disconnect from Azure DevOps
Disconnect-AzAccount
