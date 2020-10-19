variable "region" {
  default = "us-east-1"
}
variable "key_name" {

default = "pranay1"

}
variable "instance_type" {
  default = "t2.micro"
}

variable "amis" {
  default = {
    us-east-1 = "ami-032930428bf1abbff"
  }
}

variable "subnet_id_pub1" {}
variable "pub_sg_id" {}
variable "elb_TG_arn" {}
variable "vpc_id" {}

