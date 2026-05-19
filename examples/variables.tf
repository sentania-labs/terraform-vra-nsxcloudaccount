variable "username" {
  type        = string
  description = "NSX-T manager username"
}

variable "password" {
  type        = string
  sensitive   = true
  description = "NSX-T manager password"
}
