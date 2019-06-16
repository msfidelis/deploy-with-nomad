// resource "aws_instance" "nomad-client" {
//     count = 1
//     ami = "ami-0a313d6098716f372"
//     instance_type = "t2.micro"

//     subnet_id = "${aws_subnet.public_subnet_us_east_1a.id}"

//     associate_public_ip_address = true

//     vpc_security_group_ids = ["${aws_security_group.nomad_client.id}"]

//     key_name = "${var.cluster_key}"

//     root_block_device {
//         volume_size = "60"
//         volume_type = "standard"
//     }

//     tags {
//         Name        = "${var.cluster_name}-client"
//         Workload    = "nomad"
//         Role        = "nomad_client"
//     }
// }

// resource "aws_security_group" "nomad_client" {
//   vpc_id      = "${aws_vpc.cluster_vpc.id}"
//   name        = "${var.cluster_name}-client-sg"
//   description = "Allow egress from container"

//     egress {
//         from_port   = 0
//         to_port     = 0
//         protocol    = "-1"
//         cidr_blocks = ["0.0.0.0/0"]
//     }

//     ingress {
//         from_port   = 8
//         to_port     = 0
//         protocol    = "icmp"
//         cidr_blocks = ["0.0.0.0/0"]
//     }

//     ingress {
//         from_port   = 22
//         to_port     = 22
//         protocol    = "tcp"
//         cidr_blocks = ["0.0.0.0/0"]
//     }

//     ingress {
//         from_port = 0
//         to_port = 65535
//         protocol = "tcp"
//         security_groups = ["${aws_security_group.nomad_server.id}"]
//         description = "servers"
//     }

//     ingress {
//         from_port = 0
//         to_port = 65535
//         protocol = "tcp"
//         self = true
//         description = "clients"
//     }

//     tags {
//         Name        = "${var.cluster_name}-ecs-service-sg"
//         Environment = "${var.cluster_name}"
//     }
// }