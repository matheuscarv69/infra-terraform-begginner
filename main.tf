terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "dev" {
  count                  = 3
  ami                    = "ami-0b0d54b52c62864d6"
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["${aws_security_group.ssh-access.id}"]
  tags = {
    Name = "dev-${count.index}"
  }
}

resource "aws_instance" "dev-4" {
  ami                    = "ami-0b0d54b52c62864d6"
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["${aws_security_group.ssh-access.id}"]
  tags = {
    Name = "dev-4"
  }
  depends_on = [
    aws_s3_bucket.dev-4
  ]
}

resource "aws_security_group" "ssh-access" {
  name        = "ssh-access"
  description = "ssh-access for ec2 instances"
  vpc_id      = "vpc-070601c7f0fab9290"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["45.232.38.143/32"]
  }

  tags = {
    Name = "ssh-access"
  }
}

resource "aws_s3_bucket" "dev-4" {
  bucket = "infra-terraform-begginner-dev-4"

  tags = {
    Name = "infra-terraform-begginner-dev-4"
  }
}

resource "aws_s3_bucket_acl" "infra-terraform-begginner-dev4" {
  bucket = aws_s3_bucket.dev-4.id
  acl    = "private"
}
