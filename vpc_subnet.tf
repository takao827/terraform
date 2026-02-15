######################################################################
# VPC サブネット 設定
######################################################################

resource "aws_subnet" "subnet_pub_a" {
  vpc_id = aws_vpc.vpc.id

  cidr_block = "10.0.0.0/24"

  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "subnet-pub-a"
  }
}

resource "aws_subnet" "subnet_prv_a" {
  vpc_id = aws_vpc.vpc.id

  cidr_block = "10.0.1.0/24"

  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "subnet-prv-a"
  }
}
