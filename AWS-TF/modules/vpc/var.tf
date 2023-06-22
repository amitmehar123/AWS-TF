variable "region" {

default = "us-east-1"

}

variable "vpc_cidr" {

default = "10.0.0.0/24"

}

variable "vpc_id" {}

variable "subnet_cidr1" {

type = list
default = ["10.0.0.0/26","10.0.0.64/26"]

}

variable "subnet_cidr2" {

type = list
default = ["10.0.0.128/26","10.0.0.192/26"]

}



data "aws_availability_zones" "azs" {}

variable "subnet_id_pub1" {}

