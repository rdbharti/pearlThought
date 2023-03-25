resource "aws_security_group" "jenkins_sg" {
  name = "security group from terraform"

  ingress {
    description = "SSH from the internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "80 from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "8080 from the internet"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_instance" "jenkins" {

  ami                         = "ami-04581fbf744a7d11f"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = true
  key_name                    = "pearlThoughts" # your key here
  user_data = "${file("config.sh")}"

  tags = {
    Name = "Jenkins-Server"
  }

}

output "instance_ip" {
  value = aws_instance.jenkins.public_ip
}