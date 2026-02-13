######################################################################
# Webサーバー設定
######################################################################

data "template_file" "web_shell" {
  template = file("${path.module}/web.sh.tpl")
}

resource "aws_instance" "mywebserver" {
  ami           = data.aws_ami.amzn2.id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.auth.id

  # ネットワーク設定
  subnet_id              = aws_subnet.subnet_pub_a.id
  vpc_security_group_ids = [aws_security_group.mywebserver.id]

  # ストレージの設定
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  tags = {
    Name = "web-instance"
  }

  user_data_base64 = base64encode(data.template_file.web_shell.rendered)
}
