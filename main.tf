provider "aws" {
  version = "~> 4.0"
  region  = "us-east-1"
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