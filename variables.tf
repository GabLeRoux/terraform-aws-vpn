variable "region" {
  type    = "string"
  default = "ca-central-1"
}

variable "ec2_ssh_key_name" {
  type    = "string"
  default = "gableroux_aws_rsa"
}

variable "ec2_provisioning_ssh_connection_key_path" {
  type    = "string"
  default = "~/.ssh/gableroux_aws_rsa"
}

variable "authorized_ips_range" {
  type = "list"

  default = [
    "0.0.0.0/0",
  ]
}

variable "vpc_cidr_block" {
  type = "string"
  default = "172.32.0.0/16"
}

variable "ami" {
  # ubuntu 18.04
  default = "ami-0ac019f4fcb7cb7e6"
}
