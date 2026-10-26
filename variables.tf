variable "name" {
  type        = string
  description = "The name of the NSX-T cloud account"
}

variable "username" {
  type        = string
  description = "The username for the NSX-T service account"

  validation {
    condition     = length(trimspace(var.username)) > 0
    error_message = "username must not be empty."
  }
}

variable "password" {
  type        = string
  sensitive   = true
  description = "The password for the NSX-T service account"

  validation {
    condition     = length(var.password) > 0
    error_message = "password must not be empty."
  }
}

variable "hostname" {
  type        = string
  description = "The FQDN, IPv4 address, or IPv6 address (bare or bracketed) of the NSX-T manager, without a URL scheme, port, or path"

  validation {
    condition = (
      can(regex("^[A-Za-z0-9]([A-Za-z0-9.-]*[A-Za-z0-9])?\\.?$", var.hostname))
      || can(cidrhost("${try(regex("^\\[([0-9A-Fa-f:.]+)\\]$", var.hostname)[0], var.hostname)}/128", 0))
    )
    error_message = "hostname must be a bare FQDN, IPv4 address, or IPv6 address (bare or bracketed), with no URL scheme, port, path, or whitespace."
  }
}

variable "accept_self_signed_cert" {
  type        = bool
  default     = false
  description = "Whether vRA should accept a self-signed or otherwise untrusted TLS certificate from the NSX-T manager. Defaults to false so the certificate is verified; set to true only for managers that present a certificate vRA does not trust, which leaves the connection open to impersonation."
}

variable "capability_tags" {
  type = list(object({
    key   = string
    value = string
  }))
  description = "Capability tags to be applied to the Cloud Account"
  default     = []

  validation {
    condition     = alltrue([for t in var.capability_tags : length(trimspace(t.key)) > 0])
    error_message = "Every capability tag must have a non-empty key."
  }
}


variable "description" {
  type        = string
  default     = ""
  description = "A description for the cloud account"
}
