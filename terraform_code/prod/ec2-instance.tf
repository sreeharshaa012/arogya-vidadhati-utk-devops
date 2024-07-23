resource "aws_instance" "utkdevops-server" {
    ami = "ami-06c68f701d8090592" 
    instance_type = "t2.micro"
    key_name = "utkdevops"
    security_groups = [ "utkdevops-sg" ]
    vpc_security_group_ids = [aws_security_group.utkdevops-sg.id]
    subnet_id = aws_subnet.utkdevops-public-subnet-01.id 
    //for_each = toset(["jenkins-master", "build-slave", "ansible"])
    //   tags = {
    //     Name = "${each.key}"
   //}
}