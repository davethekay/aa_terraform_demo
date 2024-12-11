# Define common tags for each resource locally
locals {
  common_tags = {
    ManagedBy = "Terraform"
    Project   = "proj_aa_demo"
    Author    = "David Kavanaugh"
  }
}

# Create a public vpc
resource "aws_vpc" "vpc_main_aa" {
  cidr_block = "10.0.0.0/16"

  tags = merge(local.common_tags, {
    vpcName = "vpc_aa"
    Name    = "VPC_AA"
  })
}

# Create a public subnet
resource "aws_subnet" "subnet_public_aa" {
  vpc_id                  = aws_vpc.vpc_main_aa.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true # Add this to make a subnet public, default is false (private)

  tags = merge(local.common_tags, {
    vpcSubnetPublicName = "subnet_public_aa"
    Name                = "SUBNET_PUBLIC_AA"
  })
}

# Create a private subnet
resource "aws_subnet" "subnet_private_aa" {
  vpc_id     = aws_vpc.vpc_main_aa.id
  cidr_block = "10.0.1.0/24"

  tags = merge(local.common_tags, {
    vpcSubnetPrivateName = "subnet_private_aa"
    Name = "SUBNET_PRIVATE_AA"
  })

}

# Connect an Internet Gateway to this VPC
resource "aws_internet_gateway" "igw_aa" {
  vpc_id = aws_vpc.vpc_main_aa.id

  tags = merge(local.common_tags, {
    internetGatewayName = "internet_gateway_aa"
    Name = "INTERNET_GATEWAY_PUBLIC_AA"
  })
}

# Create a route table
resource "aws_route_table" "route_main_aa" {
  vpc_id = aws_vpc.vpc_main_aa.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_aa.id
  }

  tags = merge(local.common_tags, {
    routeTableName = "route_table_aa"
    Name = "ROUTE_TABLE_AA"
  })
}

# Associate the route table for public subnet
# We do NOT associate the private subnet to an IGW
resource "aws_route_table_association" "public_route_aa" {
  subnet_id      = aws_subnet.subnet_public_aa.id
  route_table_id = aws_route_table.route_main_aa.id
}