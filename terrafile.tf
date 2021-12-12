module "servers" {
  source  = "./servers"
  servers = 1
  
  providers = {
    aws = "aws.east2"
  }
  ebs = [
  {
    device_name = "/dev/sdg"
    volume_size = 5
    volume_type = "gp2"
  },
  {
    device_name = "/dev/sdh"
    volume_size = 10
    volume_type = "gp2"
  },
]
}

output "ip_address" {
  value = module.servers.ip_address
}
