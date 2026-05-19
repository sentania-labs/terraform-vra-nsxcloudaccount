module "nsx_cloud_account" {
  source = "../"

  name     = "nsx-manager-01"
  hostname = "nsxmgr01.example.com"
  username = var.username
  password = var.password

  capability_tags = [
    { key = "cloud", value = "nsx" }
  ]
}
