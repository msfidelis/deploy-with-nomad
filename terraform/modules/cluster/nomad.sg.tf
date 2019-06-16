resource "aws_security_group" "nomad_server" {
  vpc_id      = "${var.vpc_id}"
  name        = "${var.cluster_name}-server-sg"
  description = "Allow egress from container"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 0
      to_port = 65535
      protocol = "tcp"
      self = true
      description = "servers"
  }

  tags {
    Name        = "${var.cluster_name}-ecs-service-sg"
    Environment = "${var.cluster_name}"
  }
}

resource "aws_security_group" "nomad_client" {
  vpc_id      = "${var.vpc_id}"
  name        = "${var.cluster_name}-client-sg"
  description = "Allow egress from container"

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 8
        to_port     = 0
        protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        security_groups = ["${aws_security_group.nomad_server.id}"]
        description = "servers"
    }

    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        self = true
        description = "clients"
    }

    tags {
        Name        = "${var.cluster_name}-ecs-service-sg"
        Environment = "${var.cluster_name}"
    }
}