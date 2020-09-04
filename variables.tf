
variable "allowed_ips" {
  type = list(string)
}

variable "environment" {
  type = string
}

variable "key_name" {
  type = string
}

variable "region" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}
