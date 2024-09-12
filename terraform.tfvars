vpc_cidr = "10.10.0.0/16"
vpc_name = "project_vpc"
public_subnets = {
  subnet_a = {
    cidr_block        = "10.10.2.0/24"
    availability_zone = "us-east-1a"
    name              = "public_subnet_a"
  }
  subnet_b = {
    cidr_block        = "10.10.4.0/24"
    availability_zone = "us-east-1b"
    name              = "public_subnet_b"
  }
}
private_appsubnets = {
  subnet_a = {
    cidr_block        = "10.10.1.0/24"
    availability_zone = "us-east-1a"
    name              = "app_subnet_a"
  }
  subnet_b = {
    cidr_block        = "10.10.3.0/24"
    availability_zone = "us-east-1b"
    name              = "app_subnet_b"
  }
}
private_dbsubnets = {
  subnet_a = {
    cidr_block        = "10.10.5.0/24"
    availability_zone = "us-east-1a"
    name              = "db_subnet_a"
  }
  subnet_b = {
    cidr_block        = "10.10.7.0/24"
    availability_zone = "us-east-1b"
    name              = "db_subnet_b"
  }
}

instance_type   = "t2.micro"

db_instance_count = 1
db_storage        = 10
engine            = "postgres"
db_engine_version = "16.3"
db_instance_class = "db.t3.micro"
db_identifier     = "db"

cluster_name = "bookshop_cluster"




