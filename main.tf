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

# module "database" {
#   source                = "./database"
#   vpc_id                = module.networking.vpc_id
#   # app_security_group_id = module.compute.app_security_group_id
#   db_instance_count     = var.db_instance_count
#   db_storage            = var.db_storage
#   engine                = var.engine
#   db_engine_version     = var.db_engine_version
#   db_instance_class     = var.db_instance_class
#   db_subnet_group_name  = module.networking.db_subnet_group_names[0]
#   db_identifier         = var.db_identifier
#   multi_az              = false
#   skip_db_snapshot      = true
# }

# module "loadbalancing" {
#   source                 = "./loadbalancing"
#   vpc_id                 = module.networking.vpc_id
#   app_security_group_id  = module.compute.app_security_group_id
#   public_subnets         = module.networking.public_subnets
#   tg_port                = var.tg_port
#   tg_protocol            = var.tg_protocol
#   lb_healthy_threshold   = var.lb_healthy_threshold
#   lb_unhealthy_threshold = var.lb_unhealthy_threshold
#   lb_timeout             = var.lb_timeout
#   lb_interval            = var.lb_interval
#   listener_port          = var.listener_port
#   listener_protocol      = var.listener_protocol
# }

# module "application" {
#     source = "./application"
#     cluster_name = var.cluster_name
#     private_appsubnets = module.networking.private_appsubnets
# }



