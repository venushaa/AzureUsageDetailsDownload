#Variables
$rg = Read-Host -Prompt 'Enter a name for the resource group to contain all objects'
$loc = Read-Host -Prompt "Specify an Azure Region to deploy the resource group (ex: eastus, eastus2, canadacentral)"
$armname = Read-Host -Prompt 'Provide a name for the ARM deployment (ex: consumptiondeployment)'
$armfile = Read-Host -Prompt 'Provide the path to the ARM template file (/home/<username>/endtoend_consumption_template_sql-v1-3.json (default path for Cloud Shell)) '
$storageAccountName = Read-Host -Prompt 'Enter a globally unique name for the Azure Storage Account resource (3-24 characters, lowercase, ex: contoso-usage-store)'
$keyVaultName = Read-Host -Prompt 'Enter a globally unique name for the Azure Key Vault resource (3-24 characters, lowercase, no special characters, ex: contosokv)'
$dataFactoryName = Read-Host -Prompt 'Enter a globally unique name for the Azure Data Factory resource (3-24 characters, lowercase, ex: contosoadf, contoso-datafactory)'
$sqlServerName = Read-Host -Prompt 'Enter a globally unique name for the Azure SQL Server resource (ex: contoso-az-usage)'
$sqladmin = Read-Host -Prompt 'Enter an administrator name for SQL Server (cannot use admin, administrator)'
$sqlpw = Read-Host -Prompt 'Enter a password for SQL Server admin' -AsSecureString
$sqldb = Read-Host -Prompt 'Enter a name for SQL database'

#Deploy new resource group to contain all resources for the ADF solution
New-AzResourceGroup -Name $rg -Location $loc

#Run arm template and deploy solution
New-AzResourceGroupDeployment -Name $armname -ResourceGroupName $rg -TemplateFile $armfile -storageAccountName $storageAccountName -keyVaultName $keyVaultName -dataFactoryName $dataFactoryName -sqladministratorlogin $sqladmin -sqladministratorloginpassword $sqlpw -sqlServerName $sqlServerName -databasename $sqldb