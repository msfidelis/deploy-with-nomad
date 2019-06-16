// resource "aws_instance" "nomad-server" {
//     count = 1
//     ami = "ami-0a313d6098716f372"
//     instance_type = "t2.micro"

//     subnet_id = "${aws_subnet.public_subnet_us_east_1a.id}"

//     associate_public_ip_address = true

//     vpc_security_group_ids = ["${aws_security_group.nomad_server.id}"]

//     key_name = "${var.cluster_key}"

//     root_block_device {
//         volume_size = "60"
//         volume_type = "standard"
//     }

//     tags {
//         Name        = "${var.cluster_name}-server"
//         Workload    = "nomad"
//         Role        = "nomad_server"
//     }
// }

// resource "aws_security_group" "nomad_server" {
//   vpc_id      = "${aws_vpc.cluster_vpc.id}"
//   name        = "${var.cluster_name}-server-sg"
//   description = "Allow egress from container"

//   egress {
//     from_port   = 0
//     to_port     = 0
//     protocol    = "-1"
//     cidr_blocks = ["0.0.0.0/0"]
//   }

//   ingress {
//     from_port   = 8
//     to_port     = 0
//     protocol    = "icmp"
//     cidr_blocks = ["0.0.0.0/0"]
//   }

//   ingress {
//     from_port   = 22
//     to_port     = 22
//     protocol    = "tcp"
//     cidr_blocks = ["0.0.0.0/0"]
//   }

//   ingress {
//       from_port = 0
//       to_port = 65535
//       protocol = "tcp"
//       self = true
//       description = "servers"
//   }

//   tags {
//     Name        = "${var.cluster_name}-ecs-service-sg"
//     Environment = "${var.cluster_name}"
//   }
// }