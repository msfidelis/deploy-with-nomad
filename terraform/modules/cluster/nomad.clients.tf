resource "aws_instance" "nomad_client" {
    count           = 1
    ami             = "${var.cluster_ami}"
    instance_type   = "t2.micro"

    subnet_id       = "${var.public_subnet_1a}"

    associate_public_ip_address = true

    vpc_security_group_ids = ["${aws_security_group.nomad_client.id}"]

    key_name        = "${var.cluster_key}"

    root_block_device {
        volume_size = "60"
        volume_type = "standard"
    }

    tags {
        Name        = "${var.cluster_name}-client"
        Workload    = "nomad"
        Role        = "nomad_client"
    }
}