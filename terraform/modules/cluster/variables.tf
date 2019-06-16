variable "cluster_name" {
  description = "The cluster_name"
}

variable "alb_port" {
  description = "Origin Application Load Balancer Port"
}

# Target Group Load Balancer Port
variable "container_port" {
  description = "Destination Application Load Balancer Port"
}

variable "cluster_key"{
  description = "cluster key"
}

variable "vpc_id" {
    description = ""
}

variable "public_subnet_1a"{
    description = "cluster public subnet"
}

variable "public_subnet_1b"{
    description = "cluster public subnet"
}

variable "cluster_ami" {
    description = "Build an AMI image using packer and put here"
}