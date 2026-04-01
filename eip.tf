resource "aws_eip" "eip_websrv" {
  domain = "vpc"

  tags = {
    Name = "eip-websrv"
  }
}

resource "aws_eip_association" "eip_websrv_assoc" {
  instance_id = aws_instance.websrv_a.id

  allocation_id = aws_eip.eip_websrv.id
}
