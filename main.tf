# data "terraform_remote_state" "network" {
#   backend = "s3"
#   config = {
#     bucket = "tfremotestate-vpc"
#     key    = "state"        // Path to state file within this bucket
#     region = "eu-central-1" // Change this to the appropriate region
#   }
# }

# output subnet_ids {
#   value = data.terraform_remote_state.network.outputs.subnets
# }

data "aws_subnets" "my_subnets" {
  filter {
    name   = "vpc-id"
    values = ["vpc-0cb1aa34b173b1bb6"] // replace this with your VPC id
  }
}

resource "aws_instance" "my_vm" {
  // for terraform_remote_state
  // for_each      = toset(data.terraform_remote_state.network.outputs.subnets)
  // for aws_subnets data source
  for_each      = toset(data.aws_subnets.my_subnets.ids)
  ami           = var.ami //Ubuntu AMI
  instance_type = var.instance_type

  subnet_id = each.key

  tags = {
    Name = var.name_tag,
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "tfremotestate-vpc"
    key    = "state"
    region = "eu-central-1"
  }
}
