# devops-azuread-application
Azure Devops deploy Azure AD application

## Terraform

```powershell
# Get AZ storage key.
(Get-AzStorageAccountKey -ResourceGroupName terraform-state -Name mdterraform)[0].value
# Get service principal details.
Get-AzADServicePrincipal -DisplayName 'terraform-azuread'
```

Terraform State in Azure Storage

```bash
 export ARM_ACCESS_KEY=<storage access key>
```

Authenticate to Azure with Service principal for terraform.

```bash
export ARM_CLIENT_ID="00000000-0000-0000-0000-000000000000"
export ARM_TENANT_ID="10000000-2000-3000-4000-500000000000"
 export ARM_CLIENT_SECRET="00000000-0000-0000-0000-000000000000"
```

### Set application password

Set as an environment variable.

```bash
 export TF_VAR_app_password=''
```

```bash
terraform apply -var-file="variables.tfvars"
```