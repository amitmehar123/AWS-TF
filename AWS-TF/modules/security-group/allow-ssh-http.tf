provider "aws" {

region = "${var.region}"

}

resource "aws_security_group" "myvpc-SG" {

  name = "myvpc-SG"
  description = "Web Security Group"
  vpc_id   =  "${var.vpc_id}"
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "myvpci-pubSG"
  }


}

output "pub_sg_id" {

   value = "${aws_security_group.myvpc-SG.id}"

}






