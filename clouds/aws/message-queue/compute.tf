data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-*"]
  }

  owners = ["099720109477"]  # Canonical owner ID for Ubuntu AMIs
}

resource "aws_key_pair" "key" {
  key_name = "${var.prefix}-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIusbIEYe/J5stMvUhwehdhiWYEv/g2idHPzuxV35I6H hey@instant-infra.com"
}


resource "aws_instance" "test" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  iam_instance_profile = aws_iam_instance_profile.ip.name
  key_name = aws_key_pair.key.key_name

  subnet_id = aws_subnet.subnets[0].id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  user_data = file("init.sh")
}


output "ami_id" {
  value = data.aws_ami.ubuntu.id
}