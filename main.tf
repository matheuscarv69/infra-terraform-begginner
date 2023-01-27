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

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

resource "aws_instance" "dev" {
  count                  = 3
  ami                    = var.amis["sa-east-1"]
  instance_type          = var.ec2_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = ["${aws_security_group.ssh-access.id}"]
  tags = {
    Name = "dev-${count.index}"
  }
}

resource "aws_instance" "dev-4" {
  ami                    = var.amis["sa-east-1"]
  instance_type          = var.ec2_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = ["${aws_security_group.ssh-access.id}"]
  tags = {
    Name = "dev-4"
  }
  depends_on = [
    aws_s3_bucket.dev-4
  ]
}

resource "aws_instance" "dev-5" {
  provider               = aws.us-east-1
  ami                    = var.amis["us-east-1"]
  instance_type          = var.ec2_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = ["${aws_security_group.ssh-access-us-east-1.id}"]
  tags = {
    Name = "dev-5"
  }
  depends_on = [
    aws_dynamodb_table.dynamodb-homologation-us-east-1
  ]
}

resource "aws_s3_bucket" "dev-4" {
  bucket = "infra-terraform-begginner-dev-4"

  tags = {
    Name = "infra-terraform-begginner-dev-4"
  }
}

resource "aws_s3_bucket_acl" "infra-terraform-begginner-dev-4" {
  bucket = aws_s3_bucket.dev-4.id
  acl    = "private"
}
