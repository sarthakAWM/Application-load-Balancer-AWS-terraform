variable "ami_id"{
	type    = string
    default = "ami-07c1207a9d40bc3bd"
}

variable "instance_type"{
     type    = string
	 default = "t2.micro"
}

variable "key_pair"{
	type    = string
	default = "ansibleAndTerraform"
}

variable "security_group"{
	type    = list(string)
}

variable "user_data"{
	type    = string
}

variable "name_prefix"{
	type    = string
}

variable "autoscaling_name"{
	type    = string
}

variable "vpc_zone_identifier"{
	type    = list(string)

}

variable "min_size"{
	type    = number
}

variable "max_size"{
	type    = number
}

variable "target_group_arns"{
	type    = list(string)
}



