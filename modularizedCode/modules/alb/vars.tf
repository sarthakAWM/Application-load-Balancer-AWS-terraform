variable "name_load_balance"{
	type = string
}

variable "subnets"{
	type = list(string)
}

variable "security_groups"{
	type = list(string)
	
}

variable "target_group_name"{
	type = string
}

variable "vpc_id"{
	type = string
}

