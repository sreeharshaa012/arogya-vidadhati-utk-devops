resource "aws_vpc" "utkdevops-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "utkdevops-vpc"
  }
}