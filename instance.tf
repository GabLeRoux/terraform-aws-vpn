resource "aws_instance" "server_vpn" {
  ami               = "${var.ami}"
  instance_type     = "t2.micro"
  availability_zone = "${aws_subnet.vpn-1a.availability_zone}"

  subnet_id                   = "${aws_subnet.vpn-1a.id}"
  associate_public_ip_address = true
  disable_api_termination     = false

  vpc_security_group_ids = [
    "${aws_security_group.vpn_sg.id}",
  ]

  key_name = "${var.ec2_ssh_key_name}"

  tags {
    Name = "VPN Server"
  }

  provisioner "file" {
    source      = "./.env.vpn"
    destination = "~/.env"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file(var.ec2_provisioning_ssh_connection_key_path)}"
    }
  }

  provisioner "remote-exec" {
    scripts = [
      "scripts/provision_vpn.sh",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file(var.ec2_provisioning_ssh_connection_key_path)}"
    }
  }
}
