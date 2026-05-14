output "cloud_account" {
  description = "The NSX-T cloud account name, ID, and hostname"
  value = {
    "name"     = vra_cloud_account_nsxt.this.name,
    "id"       = vra_cloud_account_nsxt.this.id,
    "hostname" = vra_cloud_account_nsxt.this.hostname
  }
}
