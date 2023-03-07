# VariableGroupToKeyVault

Sample azure cli script to copy variable values to secrets in kayvault

Execute with following command -
.\Export-VariableGroups.ps1 -organizationName "MyOrganization" -projectName "MyProject" -variableGroupKeyVaultPairs @(
    @{ variableGroup = "VariableGroup1"; keyVaultName = "KeyVault1"; keyVaultResourceGroupName = "ResourceGroup1" },
    @{ variableGroup = "VariableGroup2"; keyVaultName = "KeyVault2"; keyVaultResourceGroupName = "ResourceGroup2" }
)
