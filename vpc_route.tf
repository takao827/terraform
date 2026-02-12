resource "aws_route_table" "inettable" {
    vpc_id = aws_vpc.vpc.id

    route {
        gateway_id = aws_internet_gateway.myig.id
        cidr_block = "0.0.0.0/0"
    }

    tags = {
        Name = "rtb-mysubnet01"
    }
}

resource "aws_route_table_association" "inettable" {
    subnet_id = aws_subnet.mysubnet01.id

    route_table_id = aws_route_table.inettable.id
}