resource "aws_launch_configuration" "Test-launchconfig" {
  name_prefix     = "Test-launchconfig"
  
  #ami id  amazon linux 2
  image_id        = "ami-07c1207a9d40bc3bd"

  #instance type
  instance_type   = "t2.micro"
  key_name        = "ansibleAndTerraform"
  security_groups = [aws_security_group.myinstance.id]

  # user data to install required server and tools
  user_data       = "#!/bin/bash\napt-get update\napt-get -y install nginx\nMYIP=`ifconfig | grep 'addr:10' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'the ip of the host is: '$HOSTNAME > /var/www/html/index.html"
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "Test-autoscaling" {
  name                      = "Test-autoscaling"
  vpc_zone_identifier       = [aws_subnet.main-private-1.id,aws_subnet.main-private-2.id]
  launch_configuration      = aws_launch_configuration.TestSJ-launchconfig.name
  # min size of the cluster
  min_size                  = 2
  # min size of the cluster
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true

  # To attach autoscaling group to Target groups of application load balancer
  target_group_arns = [aws_alb_target_group.alb-target-group.arn]

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}
