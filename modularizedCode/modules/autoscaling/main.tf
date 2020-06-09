resource "aws_launch_configuration" "TestSJ-launchconfig" {
  name_prefix     = var.name_prefix
  image_id        = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_pair
  security_groups = var.security_group
  user_data       = var.user_data
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "TestSJ-autoscaling" {
  name                      = var.autoscaling_name
  vpc_zone_identifier       = var.vpc_zone_identifier
  launch_configuration      = aws_launch_configuration.TestSJ-launchconfig.name
  min_size                  = var.min_size
  max_size                  = var.max_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  target_group_arns = var.target_group_arns

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}
