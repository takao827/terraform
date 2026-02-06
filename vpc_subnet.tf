######################################################################
# VPC サブネット 設定
######################################################################

resource "aws_subnet" "mysubnet01" {
    vpc_id = aws_vpc.vpc.id

    cidr_block = "10.0.0.0/24"

    availability_zone = "ap-northeast-1a"

    tags = {
        Name = "mysubnet01"
    }
}