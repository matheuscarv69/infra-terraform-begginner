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