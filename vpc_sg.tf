######################################################################
# Webサーバー用 SG設定
######################################################################

resource "aws_security_group" "websrv_sg" {
  name = "websrv-sg"

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "websrv-sg"
  }
}

resource "aws_security_group_rule" "ingress_pub_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.websrv_sg.id
}

resource "aws_security_group_rule" "ingress_pub_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.websrv_sg.id
}

resource "aws_security_group_rule" "ingress_pub_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.websrv_sg.id
}

resource "aws_security_group_rule" "egress_pub_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.websrv_sg.id
}

######################################################################
# DBサーバー用 SG設定
######################################################################

resource "aws_security_group" "dbsrv_sg" {
  name = "dbsrv-sg"

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "dbsrv-sg"
  }
}

resource "aws_security_group_rule" "ingress_prv_3306" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = [aws_subnet.subnet_prv_a.cidr_block]
  security_group_id = aws_security_group.dbsrv_sg.id
}

resource "aws_security_group_rule" "egress_prv_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dbsrv_sg.id
}
