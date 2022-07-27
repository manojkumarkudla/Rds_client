resource "aws_route_table" "internet_route_tbl" {
  vpc_id = aws_vpc.db_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "internet-route-table"
  }
}
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.db_vpc.id

  tags = {
    Name = "internet_gateway"
  }
}

resource "aws_eip" "db_eip" {
  vpc = true
}


resource "aws_nat_gateway" "db_nat_gateway" {
  allocation_id = aws_eip.db_eip.id
  subnet_id     = aws_subnet.publicsubnet.id

  tags = {
    Name = " NAT gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_gateway]
}
resource "aws_route_table" "nat_route_tbl" {
  vpc_id = aws_vpc.db_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.db_nat_gateway.id
  }

  tags = {
    Name = "nat-route-table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.publicsubnet.id
  route_table_id = aws_route_table.internet_route_tbl.id
}

resource "aws_route_table_association" "priv-subnet1"{
  subnet_id      = aws_subnet.priv-subnet1.id
  route_table_id = aws_route_table.nat_route_tbl.id
}

resource "aws_route_table_association" "priv-subnet2" {
  subnet_id      = aws_subnet.priv-subnet2.id
  route_table_id = aws_route_table.nat_route_tbl.id
}