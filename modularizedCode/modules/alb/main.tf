resource "aws_alb" "my-alb" {  
  name            =  var.name_load_balance
  subnets         =  var.subnets
  security_groups =  var.security_groups
  internal        = false    
  tags = {    
    Name    = "alb" 
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


# target group , can create many target group using the same code but changing the name
resource "aws_alb_target_group" "alb-target-group" {  
  name     = var.target_group_name 

  # Port to listen 
  port     = "80"  

  # Protocol
  protocol = "HTTP"  
  vpc_id   = var.vpc_id
  
  tags = {    
    Name    = "targetGroup"    
  } 

  health_check {    
    healthy_threshold   = 3    
    unhealthy_threshold = 10    
    timeout             = 5    
    interval            = 10
    # where index.html is located    
    path                = "/"    
    port                = "80"  
  }
}

