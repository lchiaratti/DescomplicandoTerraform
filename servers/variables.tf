variable "image_id" {
  default     = "ami-0629230e074c580f2"
  type        = string
  description = "The id of the machine image (AMI) to use for the server"

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "servers" {
}

variable "environment" {
  type = string
  #type = list(number)
  default     = "staging"
  description = "The environment of instance"
}

variable "plus" {
  default = 2
}

variable "production" {
  default = false
}

variable "sg" {
  type        = list(number)
  default     = [1, 2, 3, 4] # IDs do Security Groups da AWS
  description = "The list od SG for this instance"
}

variable "instance_type" {
  type        = list(string)
  default     = ["t2.micro", "t3.medium"]
  description = "The list of instance type"
}

variable "ebs" {
  type = list(object({
    device_name = string
    volume_size = string
    volume_type = string
  }))
  description = "List of EBS Block"
}

variable "name" {
  type = string
  default = "Homologação"
  description = "Nome do hello word"
}