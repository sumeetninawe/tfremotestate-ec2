resource "aws_instance" "my_vm" {
 ami           = var.ami //Ubuntu AMI
 instance_type = var.instance_type

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
