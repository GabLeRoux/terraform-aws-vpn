output "ec2_vpn_public_ip" {
  value = "${aws_instance.server_vpn.public_ip}"
}

output "authorized_ips" {
  value = "${var.authorized_ips_range}"
}
