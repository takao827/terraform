######################################################################
# Webサーバー設定
######################################################################

data "template_file" "web_shell" {
  template = file("${path.module}/web.sh.tpl")
}

resource "aws_instance" "websrv_a" {
  ami           = data.aws_ami.amzn2.id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.auth.id

  # ネットワーク設定
  subnet_id              = aws_subnet.subnet_pub_a.id
  vpc_security_group_ids = [aws_security_group.websrv_sg.id]

  # ストレージの設定
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  tags = {
    Name = "web-instance-a"
  }

  user_data_base64 = base64encode(data.template_file.web_shell.rendered)
}

resource "aws_instance" "websrv_c" {
  ami           = "ami-060601a77eab5e040"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.auth.id

  # ネットワーク設定
  subnet_id                   = aws_subnet.subnet_pub_c.id
  vpc_security_group_ids      = [aws_security_group.websrv_sg.id]
  associate_public_ip_address = false

  # ストレージの設定
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  tags = {
    Name = "web-instance-c"
  }

  user_data_base64 = base64encode(data.template_file.web_shell.rendered)
}

data "template_file" "db_shell" {
  template = templatefile("${path.module}/db.sh.tpl", {
    DB_NAME     = var.db_name
    DB_USER     = var.db_user
    DB_PASSWORD = var.db_password
  })
}

resource "aws_instance" "dbsrv" {
  ami           = data.aws_ami.amzn2.id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.auth.id

  # ネットワーク設定
  subnet_id              = aws_subnet.subnet_prv_a.id
  vpc_security_group_ids = [aws_security_group.dbsrv_sg.id]

  # ストレージの設定
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  tags = {
    Name = "db-instance"
  }

  user_data_base64 = base64encode(data.template_file.db_shell.rendered)
}
