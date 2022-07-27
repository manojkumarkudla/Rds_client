data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }


  owners = ["099720109477"] # Canonical
}

# data "aws_vpc" "db_vpc" {
#   filter {
#     name   = "tag:Name"
#     values = ["lab-vpc2"]
#   }

# }

# data "aws_subnet" "publicsubnet" {
#   filter {
#     name   = "tag:Name"
#     values = ["public_subnet"]
#   }

# }