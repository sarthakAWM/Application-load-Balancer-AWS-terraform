#At the end of terraform apply this output will be dispalyed 


#Displaying DNS name of ALB after creation
output "ELB" {
  value = aws_alb.my-alb.dns_name
}

