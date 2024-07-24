resource "aws_instance" "utkdevops-server" {
    ami = "ami-0427090fd1714168b" 
    instance_type = "t2.micro"
    key_name = "utkdevops"
    //security_groups = [ "utkdevops-sg" ]
    vpc_security_group_ids = [aws_security_group.utkdevops-sg.id]
    subnet_id = aws_subnet.utkdevops-public-subnet-01.id 
    //for_each = toset(["jenkins-master", "build-slave", "ansible"])
    //   tags = {
    //     Name = "${each.key}"
   //}
    tags = {
      Name = "utkdevops-server"
    }

    #Bootstrap Jenkins installation and start  
    user_data = <<-EOF
    #!/bin/bash
        sudo yum update
        sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
        sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
        sudo yum upgrade
        amazon-linux-extras install epel -y
        sudo dnf install java-17-amazon-corretto -y
        sudo yum install jenkins -y
        sudo systemctl enable jenkins
        sudo systemctl start jenkins
    EOF

    user_data_replace_on_change = true
  }

resource "aws_eip" "ElasticIP" {
    instance = aws_instance.utkdevops-server.id
}