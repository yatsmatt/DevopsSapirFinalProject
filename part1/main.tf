terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}
#################### vpc ####################
resource "aws_vpc" "yatsil-dev-vpc" {
  cidr_block = "10.0.0.0/27"
  tags = {
    Name = "yatsil-dev-vpc"
  }
}
#################### igw ####################
resource "aws_internet_gateway" "yatsil-igw" {
  vpc_id = aws_vpc.yatsil-dev-vpc.id

  tags = {
    Name = "yatsil-igw"
  }
}
#################### router ####################
resource "aws_route_table" "yatsil-ingroute" {
  vpc_id = aws_vpc.yatsil-dev-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.yatsil-igw.id
  }
}
#################### subnet ####################
resource "aws_subnet" "yatsil-k8s-subnet" {
  vpc_id     = aws_vpc.yatsil-dev-vpc.id #the vpc add the subnet should be
  cidr_block = "10.0.0.0/27"
  tags = {
    Name = "yatsil-k8s-subnet"
  }
}



