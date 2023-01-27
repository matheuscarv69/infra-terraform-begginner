resource "aws_dynamodb_table" "dynamodb-homologation-us-east-1" {
  provider     = aws.us-east-1
  name         = "GameScores"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"
  range_key    = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  tags = {
    Name = "dynamodb-homologation-us-east-1"
  }
}
