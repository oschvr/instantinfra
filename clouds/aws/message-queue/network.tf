resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "subnets" {
  count = 3
  vpc_id = aws_vpc.vpc.id
  cidr_block = "198.162.${count.index + 1}.0/24" # 254
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "rta" {
  count = 3
  subnet_id = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "msk" {
  name_prefix = "${var.prefix}-sg-msk"
  vpc_id = aws_vpc.vpc.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ec2" {
    name_prefix = "${var.prefix}-sg-ec2"
    vpc_id = aws_vpc.vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group_rule" "msk_ec2" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  source_security_group_id = aws_security_group.ec2.id
  security_group_id = aws_security_group.msk.id
}

resource "aws_security_group_rule" "ec2_msk" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  source_security_group_id = aws_security_group.msk.id
  security_group_id = aws_security_group.ec2.id
}