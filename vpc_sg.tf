######################################################################
# Webサーバー用 SG設定
######################################################################

resource "aws_security_group" "mywebserver" {
    name   = "sg_mywebserver"
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "sg_mywebserver"
    }
}

resource "aws_security_group_rule" "ingress_mywebserver" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.mywebserver.id
}