# resource "aws_db_instance" "rds_lab" {
#   allocated_storage    = 20
#   engine               = "MySql"
#   engine_version       = "8.0"
#   instance_class       = "db.t3.micro"
#   name                 = "movies_db"
#   username             = "admin_db"
#   password             = "kudladajavane"
#   skip_final_snapshot  = true
#   multi_az             = true
#   backup_retention_period = 1
# }

# resource "aws_vpc" "rds_vpc" {
# cidr_block = "192.168.0.0/16"
# }

# resource "aws_subnet" "private-subnet1" {
# vpc_id = aws_vpc.rds_vpc.id
# cidr_block = "192.168.2.0/24"
# availability_zone = "eu-west-1a"
# }

# resource "aws_subnet" "private-subnet2" {
# vpc_id = aws_vpc.rds_vpc.id
# cidr_block = "192.168.3.0/24"
# availability_zone = "eu-west-1b"
# }

# resource "aws_db_subnet_group" "db-subnet-group" {
# name = "db subnet group"
# subnet_ids = ["{aws_subnet.private-subnet1.id}", "{aws_subnet.private-subnet2.id}"]
# }

# resource "aws_db_security_group" "db_security_group" {
#   name = "rds_sg"

#   ingress {
#     cidr = "192.168.1.0/24"
#   }
# }


resource "aws_db_instance" "mysql" {
allocated_storage = 20
identifier = "sampleinstance"
storage_type = "gp2"
engine = "mysql"
engine_version = "8.0"
instance_class = "db.t3.micro"
name = "movies_db"
username = "admin_db"
password = "manoj123"
parameter_group_name = "default.mysql8.0"
skip_final_snapshot  = true
multi_az             = true
backup_retention_period = 1
db_subnet_group_name = "${aws_db_subnet_group.db-subnet.name}"

}

resource "aws_vpc" "db_vpc" {
cidr_block = "192.168.0.0/16"
}

resource "aws_subnet" "priv-subnet1" {
vpc_id = "${aws_vpc.db_vpc.id}"
cidr_block = "192.168.2.0/24"
availability_zone = "eu-west-1a"
}


resource "aws_subnet" "priv-subnet2" {
vpc_id = "${aws_vpc.db_vpc.id}"
cidr_block = "192.168.3.0/24"
availability_zone = "eu-west-1b"
}

resource "aws_subnet" "publicsubnet" {
  vpc_id     = aws_vpc.db_vpc.id
  cidr_block = "192.168.1.0/24"

  tags = {
    Name = "public_subnet"
  }
}
resource "aws_db_subnet_group" "db-subnet" {
name = "db subnet group"
subnet_ids = ["${aws_subnet.priv-subnet1.id}", "${aws_subnet.priv-subnet2.id}"]
}

resource "aws_db_parameter_group" "default_mysql" {
  name   = "default-mysql"
  family = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }
}