resource "aws_security_group" "rds_sg" {
    vpc_id = "${aws_vpc.db_vpc.id}"
    name = "allow-rds"
    description = "allow rds"
    ingress {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
      
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]

  }
}

