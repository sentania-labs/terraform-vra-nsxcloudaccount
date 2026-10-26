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

## Security

### TLS verification

By default (`accept_self_signed_cert = false`) vRA verifies the NSX-T manager's TLS certificate, so the manager must present a certificate vRA already trusts (for example one issued by a CA in vRA's trust store). Before this input existed the module always set `accept_self_signed_cert = true`.

Set `accept_self_signed_cert = true` only for managers that present a self-signed or otherwise untrusted certificate. vRA then accepts whatever certificate is presented, so the connection, including the service account credentials sent over it, is open to man-in-the-middle impersonation. Prefer installing a trusted certificate on the manager.

### Credentials

- `password` is marked `sensitive`, but it is still stored in Terraform state. Keep state in an encrypted backend with restricted access.
- Do not put credentials in committed `.tfvars` files; pass them through environment variables (`TF_VAR_password`) or a secrets manager.
- Use a dedicated, least-privilege NSX-T service account.

### Input validation

`name`, `username`, and `password` must be non-empty, `hostname` must be a bare FQDN or IP (no scheme, port, or path), and `capability_tags` must be objects with a non-empty, unique `key` and an optional `value`. Malformed values fail at plan time. Validation messages never include the password.

### Upgrading

`accept_self_signed_cert` now defaults to `false`; consumers relying on a self-signed manager certificate must set it to `true` explicitly. `capability_tags` changed from `list(map(string))` to `list(object({ key = string, value = optional(string, "") }))`; maps with extra keys are no longer accepted.

## Tests

`terraform test` runs mocked-provider tests (`tests/`) covering both TLS modes, tag handling, input validation, and that the password never appears in outputs. No vRA connection or credentials are needed.

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
| <a name="input_accept_self_signed_cert"></a> [accept\_self\_signed\_cert](#input\_accept\_self\_signed\_cert) | Whether vRA should accept a self-signed or otherwise untrusted TLS certificate from the NSX-T manager. Defaults to false so the certificate is verified; set to true only for managers that present a certificate vRA does not trust, which leaves the connection open to impersonation. | `bool` | `false` | no |
| <a name="input_capability_tags"></a> [capability\_tags](#input\_capability\_tags) | Capability tags to be applied to the Cloud Account | <pre>list(object({<br/>    key   = string<br/>    value = optional(string, "")<br/>  }))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | A description for the cloud account | `string` | `""` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | The FQDN or IP address of the NSX-T manager, without a URL scheme, port, or path | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the NSX-T cloud account | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | The password for the NSX-T service account | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | The username for the NSX-T service account | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_account"></a> [cloud\_account](#output\_cloud\_account) | The NSX-T cloud account name, ID, and hostname |
<!-- END_TF_DOCS -->
