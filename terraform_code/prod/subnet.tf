resource "aws_subnet" "utkdevops-public-subnet-01" {
  vpc_id = aws_vpc.utkdevops-vpc.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"
  tags = {
    Name = "utkdevops-public-subnet-01"
  }
}

resource "aws_subnet" "utkdevops-public-subnet-02" {
  vpc_id = aws_vpc.utkdevops-vpc.id
  cidr_block = "10.1.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1b"
  tags = {
    Name = "utkdevops-public-subnet-02"
  }
}