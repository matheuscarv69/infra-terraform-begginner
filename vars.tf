variable "amis" {
  type = map(string)

  default = {
    "sa-east-1" = "ami-0b0d54b52c62864d6"
    "us-east-1" = "ami-0aa7d40eeae50c9a9"
  }
}
