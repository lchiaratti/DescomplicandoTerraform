
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Ubuntu
}


resource "aws_instance" "web" {
  #count         = var.servers
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  dynamic "ebs_block_device" {
    for_each = var.ebs
    content {
      device_name = ebs_block_device.value["device_name"]
      volume_size = ebs_block_device.value["volume_size"]
      volume_type = ebs_block_device.value["volume_type"]
    }
  }

  tags = {
    Name = "HelloWorld"
  }
}
# WEB2 Depende da criação do WEB1
resource "aws_instance" "web2" {
  #count         = var.environment == "production" ? 2 + var.plus : 1
  count         = var.production ? 2 : 1
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  # contar o count, se for menor que um vai criar t2, se a partir da 2 t3
  #instance_type = count.index < 1 ? "t2.micro" : "t3.medium"
  vpc_security_group_ids = var.sg

  tags = {
    Name = "HelloWorld"
    Env  = var.environment
  }
  depends_on = [aws_instance.web]
}

resource "aws_instance" "web3" {
  ami           = data.aws_ami.ubuntu.id
  for_each      = toset(var.instance_type)
  instance_type = each.value

  tags = {
    Name = "HelloWorld"
  }
}


# Elastic IP AWS - WEB01
resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.web.id
}