module "vpc" {
  source            = "./modules/vpc"
  cluster_name      = "${var.cluster_name}"
  alb_port          = "${var.alb_port}"
  container_port    = "${var.container_port}"
  cluster_key       = "${aws_key_pair.cluster_key.key_name}"
}

module "cluster" {
  source            = "./modules/cluster"
  vpc_id            = "${module.vpc.vpc_id}"
  cluster_name      = "${var.cluster_name}"
  alb_port          = "${var.alb_port}"
  container_port    = "${var.container_port}"
  cluster_ami       = "${var.cluster_ami}"
  public_subnet_1a  = "${module.vpc.public_subnet_1a}"
  public_subnet_1b  = "${module.vpc.public_subnet_1b}"
  cluster_key       = "${aws_key_pair.cluster_key.key_name}"
}

// module "pipeline" {
//   source                = "./modules/pipeline"
//   cluster_name          = "${var.cluster_name}"
//   container_name        = "${var.container_name}"
//   app_repository_name   = "${var.app_repository_name}"
//   git_repository_owner  = "${var.git_repository_owner}"
//   git_repository_name   = "${var.git_repository_name}"
//   git_repository_branch = "${var.git_repository_branch}"
//   repository_url        = "${module.ecs.repository_url}"
//   app_service_name      = "${module.ecs.service_name}"
//   account_id            = "${data.aws_caller_identity.current.account_id}"
//   vpc_id                = "${module.vpc.vpc_id}"
//   region                = "${var.aws_region}"

//   subnet_ids = [
//     "${module.vpc.public_subnet_1a}",
//     "${module.vpc.public_subnet_1b}",
//   ]
// }
