resource "aws_vpc" "vpn" {
  cidr_block           = "172.32.0.0/16"
  enable_dns_hostnames = true

  tags {
    Name = "vpc.vpn"
    Env  = "vpn"
  }
}

resource "aws_subnet" "vpn-1a" {
  vpc_id                  = "${aws_vpc.vpn.id}"
  availability_zone       = "us-east-1a"
  cidr_block              = "${cidrsubnet(aws_vpc.vpn.cidr_block, 4, 1)}"
  map_public_ip_on_launch = true

  tags {
    Name = "vpn-1a"
  }
}

resource "aws_subnet" "vpn-1b" {
  vpc_id                  = "${aws_vpc.vpn.id}"
  availability_zone       = "us-east-1b"
  cidr_block              = "${cidrsubnet(aws_vpc.vpn.cidr_block, 4, 2)}"
  map_public_ip_on_launch = true

  tags {
    Name = "vpn-1b"
  }
}

resource "aws_subnet" "vpn-1c" {
  vpc_id                  = "${aws_vpc.vpn.id}"
  availability_zone       = "us-east-1c"
  cidr_block              = "${cidrsubnet(aws_vpc.vpn.cidr_block, 4, 3)}"
  map_public_ip_on_launch = true

  tags {
    Name = "vpn-1c"
  }
}

resource "aws_subnet" "vpn-1d" {
  vpc_id                  = "${aws_vpc.vpn.id}"
  availability_zone       = "us-east-1d"
  cidr_block              = "${cidrsubnet(aws_vpc.vpn.cidr_block, 4, 4)}"
  map_public_ip_on_launch = true

  tags {
    Name = "vpn-1d"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "vpn" {
  vpc_id = "${aws_vpc.vpn.id}"

  tags {
    Name = "ig.vpn"
    Env  = "vpn"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access_vpn" {
  route_table_id         = "${aws_vpc.vpn.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.vpn.id}"
}
