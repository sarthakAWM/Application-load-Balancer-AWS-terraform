variable "var.ami_id " {
    # Amazon Linux 2 in region  ohio
    default  = "ami-07c1207a9d40bc3bd"
}


variable "ssh_key_pair" {
    default = ""
}

variable "instance_type" {
    default = "t2.micro"
}
