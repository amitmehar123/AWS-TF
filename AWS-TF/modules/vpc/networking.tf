resource "aws_vpc" "myvpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "myvpc"
  }
}

resource "aws_subnet" "subnet-pub" {

  count = "${length(var.subnet_cidr1)}"
  availability_zone = "${data.aws_availability_zones.azs.names[count.index]}"
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.subnet_cidr1[count.index]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "myvpc-pub${count.index+1}"
  }
}

resource "aws_subnet" "subnet-pri" {

  count = "${length(var.subnet_cidr2)}"
  availability_zone = "${data.aws_availability_zones.azs.names[count.index]}"
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.subnet_cidr2[count.index]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "myvpc-pri${count.index+1}"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "my-igw"
  }
}


resource "aws_route_table" "pub-RT" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.my-igw.id}"
  }

  tags = {
    Name = "pub-RT"
  }
}

resource "aws_route_table" "pri-RT" {
  vpc_id = "${var.vpc_id}"


  tags = {
    Name = "pri-RT"
  }
}

resource "aws_route_table_association" "public" {
  count = "${length(var.subnet_cidr1)}"

  subnet_id      = "${element(aws_subnet.subnet-pub.*.id, count.index)}"
  route_table_id = "${aws_route_table.pub-RT.id}"
}

resource "aws_route_table_association" "private" {
  count = "${length(var.subnet_cidr2)}"

  subnet_id      = "${element(aws_subnet.subnet-pri.*.id, count.index)}"
  route_table_id = "${aws_route_table.pri-RT.id}"
}

output "vpc_id" {
    value = "${aws_vpc.myvpc.id}"
}

output "subnet_id_pub1" {

    value = "${aws_subnet.subnet-pub.1.id}"
}

