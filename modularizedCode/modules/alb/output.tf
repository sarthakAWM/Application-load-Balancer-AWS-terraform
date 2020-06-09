output "target_group_arn"{
	value  = aws_alb_target_group.alb-target-group.arn
}

output "ALB" {
  value = aws_alb.my-alb.dns_name
}

