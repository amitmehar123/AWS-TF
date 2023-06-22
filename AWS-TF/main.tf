terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 4.18.0"
   }
 }

 backend "s3" {
   bucket = "tfbuckamit"
   key    = "state"
   region = "us-east-1"
 }
}

## code
module "my_vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = "192.168.0.0/16"
  vpc_id      = "${module.my_vpc.vpc_id}"
  subnet_cidr1 = ["192.168.1.0/24","192.168.2.0/24"]
  subnet_id_pub1 = "${module.my_vpc.subnet_id_pub1}"
  subnet_cidr2 = ["192.168.3.0/24","192.168.4.0/24"]

}

module "pub_sg" {
  source      = "./modules/security-group"
  vpc_id      = "${module.my_vpc.vpc_id}"
  pub_sg_id   = "{module.pub_sg.pub_sg_id}"
}

module "elb" {
  source      = "./modules/load-balancer"
  vpc_id      = "${module.my_vpc.vpc_id}"
  subnet_id_pub1 = "${module.my_vpc.subnet_id_pub1}"
  elb_id     = "${module.elb.elb_id}"
  elb_TG_arn = "${module.elb.elb_TG_arn}"
}

module "asg" {
  source      = "./modules/autoscaling"
  vpc_id      = "${module.my_vpc.vpc_id}"
  subnet_id_pub1 = "${module.my_vpc.subnet_id_pub1}"
  pub_sg_id   = "${module.pub_sg.pub_sg_id}"
  elb_TG_arn = "${module.elb.elb_TG_arn}"
}


