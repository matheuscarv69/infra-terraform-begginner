terraform {
  backend "remote" {
    organization = "infra-terraform-begginner"

    workspaces {
      name = "aws-infra-terraform-begginner"
    }
  }
}
