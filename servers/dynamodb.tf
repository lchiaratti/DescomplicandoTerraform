resource "aws_dynamodb_table" "dynamo-terraform-state-lock" {
  name           = "terraform-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "DynamoDB Terraform State Lock Table - %{ if var.name == "Homologação" }${var.name}%{ else }Produção%{ endif }"
  }
}