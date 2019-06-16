resource "aws_instance" "nomad-server" {
    count           = 1
    ami             = "${var.cluster_ami}"
    instance_type   = "t2.micro"

    subnet_id       = "${var.public_subnet_1a}"

    associate_public_ip_address = true

    vpc_security_group_ids = ["${aws_security_group.nomad_server.id}"]

    key_name        = "${var.cluster_key}"

    root_block_device {
        volume_size = "60"
        volume_type = "standard"
    }

    tags {
        Name        = "${var.cluster_name}-server"
        Workload    = "nomad"
        Role        = "nomad_server"
    }
}