######################################################################
# NAT Gateway 設定
######################################################################

resource "aws_eip" "eip_natgw" {
  domain = "vpc"

  tags = {
    Name = "eip-natgw"
  }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip_natgw.id
  subnet_id     = aws_subnet.subnet_pub_a.id

  tags = {
    Name = "natgw"
  }
}
