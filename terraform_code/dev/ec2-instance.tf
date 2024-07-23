provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "utkdevops-server" {
    ami = "ami-06c68f701d8090592"
    instance_type = "t2.micro"
    key_name = "utkdevops"
}
