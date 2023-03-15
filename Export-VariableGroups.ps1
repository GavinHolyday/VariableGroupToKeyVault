param (
    [Parameter(Mandatory=$true)][string]$OrganizationName,
    [Parameter(Mandatory=$true)][string]$ProjectName,
    [Parameter(Mandatory=$true)][string]$PAT,
    [Parameter(Mandatory=$true)][hashtable]$VariableGroupKeyVaultPairs
)

$ErrorActionPreference = "Stop"

# Base64 encode the personal access token
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes((":$PAT")))

# Get the project
Write-Host "Getting project: $projectName"
$uriProject = "https://dev.azure.com/$organizationName/_apis/projects?api-version=6.1-preview.4"
$project = Invoke-RestMethod -Uri $uriProject -Headers @{Authorization = "Basic $base64AuthInfo"} | Select-Object -ExpandProperty value | Where-Object { $_.name -eq $projectName }

if (!$project) {
    throw "Project not found: $projectName"
}

$variableGroups = Invoke-RestMethod -Uri "https://dev.azure.com/$OrganizationName/$ProjectName/_apis/distributedtask/variablegroups?api-version=5.1" -Headers @{Authorization = "Basic $base64AuthInfo"}

foreach ($pair in $VariableGroupKeyVaultPairs.GetEnumerator()) {
    Write-Host "Processing variable group $($pair.Name) and Key Vault $($pair.Value)..."

    $variableGroup = $variableGroups.value | Where-Object { $_.name -eq $pair.Name }

    if ($null -eq $variableGroup) {
        Write-Host "All variable groups: $($variableGroups.value | ConvertTo-Json)"
        throw "Variable group not found: $($pair.Name)"
    }

    Write-Host "Setting Key Vault secrets for variable group $($variableGroup.name) with Key Vault $keyVaultName"

    foreach ($variable in $variableGroup.variables.PSObject.Properties) {
        $variableName = $variable.Name
        $variableValue = $variable.Value.value

        Write-Host "Setting secret for variable $variableName with value $variableValue"
        
        az keyvault secret set --vault-name $pair.Value --name $variableName --value $variableValue
    }
}
