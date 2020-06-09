resource "aws_alb" "my-alb" {  
  name            = "my-alb"  
  subnets         = [aws_subnet.main-public-1.id,aws_subnet.main-public-2.id]
  security_groups = [aws_security_group.elb-securitygroup.id]
  internal        = false    
  tags = {    
    Name    = "Sarthak-alb"    
  }   
 
}

resource "aws_alb_listener" "alb-listener" {  
  load_balancer_arn = aws_alb.my-alb.arn  
  port              = "80"  
  protocol          = "HTTP"
  
  default_action {    
    target_group_arn = aws_alb_target_group.alb-target-group.arn
    type             = "forward"  
  }
}



resource "aws_alb_target_group" "alb-target-group" {  
  name     = "alb-target-group"  
  port     = "80"  
  protocol = "HTTP"  
  vpc_id   = aws_vpc.main.id
  
  tags = {    
    Name    = "sarthak_targetGroup"    
  } 

  health_check {    
    healthy_threshold   = 3    
    unhealthy_threshold = 10    
    timeout             = 5    
    interval            = 10    
    path                = "/"    
    port                = "80"  
  }
}

