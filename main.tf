# --- root/main.tf ---

module "networking" {
  source             = "./networking"
  vpc_cidr           = var.vpc_cidr
  vpc_name           = var.vpc_name
  public_subnets     = var.public_subnets
  private_appsubnets = var.private_appsubnets
  private_dbsubnets  = var.private_dbsubnets
  db_subnet_group    = true
}

module "bastion" {
  source          = "./bastion"
  vpc_id          = module.networking.vpc_id
  ssh_public_key = var.ssh_public_key
  instance_type   = var.instance_type
  public_subnet   = module.networking.bastion_public_subnet_id
}

module "database" {
  source = "./database"
  vpc_id = module.networking.vpc_id
  bastion_security_group_id = module.bastion.bastion_security_group_id
  cluster_name = var.cluster_name
  db_instance_count    = var.db_instance_count
  db_storage           = var.db_storage
  engine               = var.engine
  db_engine_version    = var.db_engine_version
  db_instance_class    = var.db_instance_class
  db_subnet_group_name = module.networking.db_subnet_group_names[0]
  db_identifier        = var.db_identifier
  multi_az             = false
  skip_db_snapshot     = true
}


module "application" {
    source = "./application"
    vpc_id = module.networking.vpc_id
    cluster_name = var.cluster_name
    private_appsubnets = module.networking.private_appsubnets
}



