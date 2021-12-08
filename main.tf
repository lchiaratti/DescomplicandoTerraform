provider "aws" {
  alias = "east2"
  region  = "us-east-2"
  version = "~> 2.0"
}

provider "aws" {
  alias = "east1"
  region  = "us-east-1"
  version = "~> 2.0"
}


terraform {
  backend "s3" {
    # Lembre de trocar o bucket para o seu, não pode ser o mesmo nome
    bucket = "descomplicando-terraform-lchiaratti-tfstates"
    # dynamodb_table = "terraform-state-lock-dynamo"
    key    = "terraform-test.tfstate"
    region = "us-east-2"
    encrypt = true
  }
}


