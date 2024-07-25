resource "aws_instance" "utkdevops-server" {
    ami = "ami-04a81a99f5ec58529" 
    instance_type = "t2.micro"
    key_name = "utkdevops"
    vpc_security_group_ids = [aws_security_group.utkdevops-sg.id]
    subnet_id = aws_subnet.utkdevops-public-subnet-01.id 
    for_each = toset(["jenkins-master", "jenkins-slave", "ansible"])
       tags = {
         Name = "${each.key}"
   }
}   
