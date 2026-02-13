resource "aws_eip" "eip_mywebserver" {
  domain = "vpc"

  tags = {
    Name = "eip-mywebserver"
  }
}

resource "aws_eip_association" "eip_mywebserver-assoc" {
  instance_id = aws_instance.mywebserver.id

  allocation_id = aws_eip.eip_mywebserver.id
}
