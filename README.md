# terraform-vra-vmapps-nsxcloudaccount

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_vra"></a> [vra](#requirement\_vra) | >= 0.3.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vra"></a> [vra](#provider\_vra) | >= 0.3.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vra_cloud_account_nsxt.this](https://registry.terraform.io/providers/vmware/vra/latest/docs/resources/cloud_account_nsxt) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capability_tags"></a> [capability\_tags](#input\_capability\_tags) | Capability tags to be applied to the Cloud Account | `list(map(string))` | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | `""` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | n/a | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_account"></a> [cloud\_account](#output\_cloud\_account) | n/a |
<!-- END_TF_DOCS -->