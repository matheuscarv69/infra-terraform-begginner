resource "aws_security_group" "ssh-access" {
  name        = "ssh-access"
  description = "ssh-access for ec2 instances"
  vpc_id      = "vpc-070601c7f0fab9290"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cdirs_remote_access
  }

  tags = {
    Name = "ssh-access"
  }
}

resource "aws_security_group" "ssh-access-us-east-1" {
  provider    = aws.us-east-1
  name        = "ssh-access-us-east-1"
  description = "ssh-access-us-east-1 for ec2 instances"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cdirs_remote_access
  }

  tags = {
    Name = "ssh-access-us-east-1"
  }
}
