resource "aws_route_table" "utkdevops-public-rt" {
  vpc_id = aws_vpc.utkdevops-vpc.id 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.utkdevops-igw.id 
  }
}

resource "aws_route_table_association" "utkdevops-rta-public-subnet-01" {
  subnet_id = aws_subnet.utkdevops-public-subnet-01.id
  route_table_id = aws_route_table.utkdevops-public-rt.id   
}

resource "aws_route_table_association" "utkdevops-rta-public-subnet-02" {
  subnet_id = aws_subnet.utkdevops-public-subnet-02.id 
  route_table_id = aws_route_table.utkdevops-public-rt.id   
}
