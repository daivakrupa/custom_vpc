resource "aws_vpc" "vpc" {
cidr_block = "${var.vpc-cidr}"
instance_tenancy        = "default"
enable_dns_hostnames    = true
tags      = {
Name    = "Custom_VPC"
}
}
resource "aws_internet_gateway" "internet-gateway" {
vpc_id    = aws_vpc.vpc.id
tags = {
Name    = "custom_internet_gateway"
}
}
resource "aws_subnet" "public-subnet-1" {
vpc_id                  = aws_vpc.vpc.id
cidr_block              = "${var.Public_Subnet_1}"
availability_zone       = "eu-central-1a"
map_public_ip_on_launch = true
tags      = {
Name    = "public-subnet-1"
}
}
resource "aws_route_table" "public-route-table" {
vpc_id       = aws_vpc.vpc.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.internet-gateway.id
}
tags       = {
Name     = "Public Route Table"
}
}
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
subnet_id           = aws_subnet.public-subnet-1.id
route_table_id      = aws_route_table.public-route-table.id
}