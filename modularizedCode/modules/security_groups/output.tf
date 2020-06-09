output "security_group_my_instance"{
	value = aws_security_group.myinstance.id
}

output "security_group_elb_securitygroup"{
	value = aws_security_group.elb-securitygroup.id
}