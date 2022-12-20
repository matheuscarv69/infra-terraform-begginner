terraform {
 required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_instance" "dev" {
  count = 3
  ami = "ami-0574da719dca65348"
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  tags = {
    Name = "dev-${count.index}"
  }
}

resource "aws_security_group" "ssh-access" {
  name        = "ssh-access"
  description = "ssh-access for ec2 instances"

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["192.168.0.110/32"]
  }

  tags = {
    Name = "ssh-access"
  }
}