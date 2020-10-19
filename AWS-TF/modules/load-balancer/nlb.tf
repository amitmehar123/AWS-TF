resource "aws_lb_target_group" "elb-TG" {
  name     = "elb-TG"
  port     = 80
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"
}


resource "aws_lb" "elb-NLB" {
  name               = "elb-NLB"
  internal           = false
  load_balancer_type = "network"
  subnets            = ["${var.subnet_id_pub1}"]
  enable_deletion_protection = false

  tags = {
    Name = "elb-NLB"
  }

}

resource "aws_lb_listener" "listen" {
  load_balancer_arn = "${aws_lb.elb-NLB.arn}"
  port              = "80"
  protocol          = "TCP"

  default_action {
    type         = "forward"
    target_group_arn = "${aws_lb_target_group.elb-TG.arn}"
  }
}

output "elb_id" {
  value = "${aws_lb.elb-NLB.id}"
}

output "elb_TG_arn" {
  value = "${aws_lb_target_group.elb-TG.arn}"
}

