provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "utkdevops-server" {
    ami = "ami-06c68f701d8090592"
    instance_type = "t2.micro"
    key_name = "utkdevops"
    //security_groups = [ "demo-sg" ]
    vpc_security_group_ids = [aws_security_group.utkdevops-sg.id]
    subnet_id = aws_subnet.utkdevops-public-subnet-01.id 

}

resource "aws_security_group" "utkdevops-sg" {
  name        = "utkdevops-sg"
  description = "SSH Access"
  vpc_id = aws_vpc.utkdevops-vpc.id 
  
  ingress {
    description      = "SSH access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ssh-port"

  }
}

resource "aws_vpc" "utkdevops-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "utkdevops-vpc"
  }
  
}

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

resource "aws_internet_gateway" "utkdevops-igw" {
  vpc_id = aws_vpc.utkdevops-vpc.id 
  tags = {
    Name = "utkdevops-igw"
  } 
}

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
