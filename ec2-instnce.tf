resource "aws_instance" "rds_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  vpc_security_group_ids =  [aws_security_group.rds_sg.id]
  key_name = "talent-academy-key-pair"
  subnet_id = aws_subnet.publicsubnet.id


  tags = {
    Name = "rds instance"
  }
}

resource "aws_eip" "rds_instance_id" {
    instance = aws_instance.rds_instance.id
    vpc = true
  
}