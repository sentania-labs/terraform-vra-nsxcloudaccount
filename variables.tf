variable "name" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}

variable "hostname" {
  type = string
}

variable "capability_tags" {
  type        = list(map(string))
  description = "Capability tags to be applied to the Cloud Account"
  default     = []
}


variable "description" {
  type    = string
  default = ""
}
