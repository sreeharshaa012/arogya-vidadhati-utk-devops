resource "aws_internet_gateway" "utkdevops-igw" {
  vpc_id = aws_vpc.utkdevops-vpc.id 
  tags = {
    Name = "utkdevops-igw"
  } 
}