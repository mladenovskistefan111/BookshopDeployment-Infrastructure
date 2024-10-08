# --- networking/main.tf ---

# Create VPC

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc_name
  }
  lifecycle {
    create_before_destroy = true
  }
}

# Create subnets in the VPC - public_subnets, private_appsubnets, private_dbsubnets

resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = each.value.name
  }
}

resource "aws_subnet" "private_appsubnets" {
  for_each                = var.private_appsubnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = false
  tags = {
    Name = each.value.name
  }
}

resource "aws_subnet" "private_dbsubnets" {
  for_each                = var.private_dbsubnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = false
  tags = {
    Name = each.value.name
  }
}

# Create InternetGW, Public Route Table that routes to the InternetGW, associate public_subnets with the Route Table

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "project_igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

# Create NAT EIPs and NATGW for each public_subnet

resource "aws_eip" "nat_eip" {
  for_each = aws_subnet.public_subnets
  domain = "vpc"
  tags = {
    Name = "nat_eip_${each.key}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat_gw" {
  for_each      = aws_subnet.public_subnets
  allocation_id = aws_eip.nat_eip[each.key].id
  subnet_id     = each.value.id
  tags = {
    Name = "nat_gw_${each.key}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

# Create Private Route Tables that route to NATGWs, associate private_appsubnets with the Route Table

resource "aws_route_table" "app_rt" {
  for_each = aws_nat_gateway.nat_gw
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = each.value.id
  }
  vpc_id   = aws_vpc.vpc.id
  tags = {
    Name = "app_rt_${each.key}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "app_rt_assoc" {
  for_each       = aws_subnet.private_appsubnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.app_rt[each.key].id
}

# Create Private Route Table, associate private_dbsubnets with the Route Table

resource "aws_route_table" "db_rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "db_rt"
  }
}

resource "aws_route_table_association" "db_rt_assoc" {
  for_each       = aws_subnet.private_dbsubnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.db_rt.id
}

# Create a DB subnet group

resource "aws_db_subnet_group" "rds_subnet_group" {
  count      = var.db_subnet_group == true ? 1 : 0
  name       = "rds_subnet_group"
  subnet_ids = [for subnet in aws_subnet.private_dbsubnets : subnet.id]
  tags = {
    Name = "rds_subnet_group"
  }
}
