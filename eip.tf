resource "aws_eip" "server_vpn" {
  instance = "${aws_instance.server_vpn.id}"
  vpc      = true

  tags {
    Name = "vpn server eip"
  }
}
