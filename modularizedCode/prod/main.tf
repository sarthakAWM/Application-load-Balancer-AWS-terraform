# code written by SARTHAK JOSHI 
# Module to create VPC with 2 private and 2 public subnets
# Futher code can be edited from the vpc module in module/vpc
module "my_vpc" {
	source = "../modules/vpc"
	vpc_cidr = "10.0.0.0/16"
}


# Module to create 2 security group  - one for instance and one for Application load balancer
module "my_security_group"{
	source = "../modules/security_groups"
	# VCP id as a parameter
	vpc_id = module.my_vpc.vpc_id

	# Name of the instance security group
	name1 = "instanceSG"

	# Name of the load blanacer security group
	name2 = "albSG"
}


# Module to create Application load balancer, Target Group and listners
module "my_alb1"{

	source = "../modules/alb"

	# Name of the load Balancer
	name_load_balance = "my-alb1"

	# Subntes for application load balancer
	subnets = [module.my_vpc.public_1_subnet_id,module.my_vpc.public_2_subnet_id] 

	# Applicaion Load Balancer Security Group
	security_groups = [module.my_security_group.security_group_elb_securitygroup]

	# Target group name 
	target_group_name = "my-target-group"

	vpc_id = module.my_vpc.vpc_id
}


module "my_autoscaling"{
	source = "../modules/autoscaling"

	#ami id - Amazon
	ami_id = var.ami_id      

	instance_type = var.instance_type
	
	# mention key name
	key_pair = var.ssh_key_pair

	security_group = [module.my_security_group.security_group_my_instance]

	#user data to install required server and tools. Here nginx will be intalled

	user_data = "#!/bin/bash\napt-get update\napt-get -y install nginx\nMYIP=`ifconfig | grep 'addr:10' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'the ip of the host is: '$HOSTNAME > /var/www/html/index.html"

	# Name of the prefix of all the instances in the cluster 
	name_prefix = "sjLaunchconfig"

	# Name of autoscaling group
	autoscaling_name ="testSJ"

	# Private subnets , instances will be ceated in this subnet
	vpc_zone_identifier = [module.my_vpc.private_1_subnet_id,module.my_vpc.private_2_subnet_id]

	# Min number of instances
	min_size = 2

	# Max size of the instances
	max_size = 3

	# Target group arn to attach it to autoscaling group
	target_group_arns = [module.my_alb1.target_group_arn]
}












