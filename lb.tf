resource "aws_lb" "alb_web" {
  name               = "alb-web"
  load_balancer_type = "application"
  internal           = false
  subnets            = [aws_subnet.subnet_pub_a.id, aws_subnet.subnet_pub_c.id]
  security_groups = [
    aws_security_group.alb_inet_sg.id,
    aws_security_group.alb_pub_sg.id,
  ]
  tags = {
    Name = "alb-web"
  }
}

resource "aws_lb_listener" "alb_web_listener" {
  load_balancer_arn = aws_lb.alb_web.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_web_tg.arn
  }
}

resource "aws_lb_target_group" "alb_web_tg" {
  name     = "alb-web-tg"
  vpc_id   = aws_vpc.vpc.id
  port     = 80
  protocol = "HTTP"
}

resource "aws_lb_target_group_attachment" "alb_web_tg_attachment_a" {
  target_id        = aws_instance.websrv_a.id
  target_group_arn = aws_lb_target_group.alb_web_tg.arn
  port             = 80
}

resource "aws_lb_target_group_attachment" "alb_web_tg_attachment_c" {
  target_id        = aws_instance.websrv_c.id
  target_group_arn = aws_lb_target_group.alb_web_tg.arn
  port             = 80
}
