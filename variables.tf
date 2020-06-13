variable "domain_name" {
  description = "Domain to be configured with Migadu email servers"
  type        = string
}

variable "migadu_verification_value" {
  description = "Value provided by Migadu to prove you own the domain"
  type        = string
}
