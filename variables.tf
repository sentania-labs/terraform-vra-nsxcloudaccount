variable "name" {
  type        = string
  description = "The name of the NSX-T cloud account"
}

variable "username" {
  type        = string
  description = "The username for the NSX-T service account"
}

variable "password" {
  type        = string
  sensitive   = true
  description = "The password for the NSX-T service account"
}

variable "hostname" {
  type        = string
  description = "The FQDN of the NSX-T manager"
}

variable "capability_tags" {
  type        = list(map(string))
  description = "Capability tags to be applied to the Cloud Account"
  default     = []
}


variable "description" {
  type        = string
  default     = ""
  description = "A description for the cloud account"
}
