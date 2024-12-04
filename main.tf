
provider "aws" {
  region  = "us-east-2"   
  profile = "default"     
}
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "MainVPC"
  }
}

resource "aws_subnet" "web_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"   
  tags = {
    Name = "WebSubnet"
  }
}
resource "aws_instance" "web_server" {
  ami           = var.ami_id        
  instance_type = "t2.micro"    
  subnet_id     = aws_subnet.web_subnet.id
  tags = {
    Name = "WebServer"
  }
}

