# Application-load-Balancer-AWS-terraform
Full terraform code to create an application load balancer with Autoscaling group and VPC (contains private sunets).

> Creates a VPC with 2 public and 2 private Subnets

> Creates 2 security group one for Application Load Balancer and  One for Launch Configuration (used in instances)

> Creates a launch Configuration and AutoScaling group

> Creates Application Load Balancer, target group and listners


# Given 2 types of Code 

1. Modularized (preferable)
   more systematic and standard
   
2. Raw 
   easy to edit and use. 
   
# To apply 
  
1.  With modularize code go to modularizedcode/dev and run terraform plan and apply.

2.  With raw code go to rawCode and run terraform plan and apply.

## !!! do not forget to add credetial(access_key and secret key),region and AMI id of that region

![alt text](https://github.com/sarthakAWM/Application-load-Balancer-AWS-terraform/blob/master/diagram.png?raw=true)
