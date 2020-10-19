resource "aws_launch_configuration" "abc-LC" {

  name  = "abc-LC"
  lifecycle { create_before_destroy = true }
  image_id = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  security_groups = ["${var.pub_sg_id}"]
  user_data = "${file("./userdata.sh")}"
  key_name = "${var.key_name}"
  associate_public_ip_address = true


}

resource "aws_autoscaling_group" "abc-asg" {
  lifecycle { create_before_destroy = true }
  vpc_zone_identifier = ["${var.subnet_id_pub1}"]
  name = "abc-asg"
  max_size = "2"
  min_size = "1"
  desired_capacity   = 1
  force_delete = true
  launch_configuration = "${aws_launch_configuration.abc-LC.name}"
  target_group_arns   = ["${var.elb_TG_arn}"]
  tag {
    key = "Name"
    value = "abc-asg"
    propagate_at_launch = "true"
  }
}

