resource "aws_security_group" "vpn_sg" {
  name_prefix = "vpn"
  description = "vpn security group"
  vpc_id      = "${aws_vpc.vpn.id}"

  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port = 500
    to_port   = 500
    protocol  = "udp"

    cidr_blocks = "${var.authorized_ips_range}"

    description = "vpn udp 500"
  }

  ingress {
    from_port = 4500
    to_port   = 4500
    protocol  = "udp"

    cidr_blocks = "${var.authorized_ips_range}"

    description = "vpn udp 4500"
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = "${var.authorized_ips_range}"

    description = "vpn ssh"
  }

  egress {
    description = "outbound internet access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.authorized_ips_range}"]
  }

  tags {
    Name = "vpn"
  }
}
