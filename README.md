# terraform-vra-nsxcloudaccount

Terraform module — registers an NSX-T manager as a cloud account in vRA / Aria Automation and applies capability tags.

## Usage example

```hcl
module "nsx_cloud_account" {
  source = "sentania-labs/nsxcloudaccount/vra"

  name     = "nsx-manager-01"
  hostname = "nsxmgr01.example.com"
  username = var.nsx_username
  password = var.nsx_password

  capability_tags = [
    { key = "cloud", value = "nsx" }
  ]
}
```

See `examples/` for a complete working configuration.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.14.0 |
| <a name="requirement_vra"></a> [vra](#requirement\_vra) | >= 0.16.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vra"></a> [vra](#provider\_vra) | >= 0.16.0 |

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
| <a name="input_description"></a> [description](#input\_description) | A description for the cloud account | `string` | `""` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | The FQDN of the NSX-T manager | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the NSX-T cloud account | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | The password for the NSX-T service account | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | The username for the NSX-T service account | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_account"></a> [cloud\_account](#output\_cloud\_account) | The NSX-T cloud account name, ID, and hostname |
<!-- END_TF_DOCS -->
