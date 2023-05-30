
# Create a VPC 
resource "aws_vpc" "ecs_vpc" {
  cidr_block = "10.0.0.0/16" # Replace with your desired VPC CIDR block
}

# Create internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.ecs_vpc.id
}

# Create a subnet 1
resource "aws_subnet" "ecs_subnet_A" {
  vpc_id            = aws_vpc.ecs_vpc.id
  cidr_block        = "10.0.0.0/24" 
  availability_zone = "us-east-1a"
}

# Create a subnet 2
resource "aws_subnet" "ecs_subnet_B" {
  vpc_id            = aws_vpc.ecs_vpc.id
  cidr_block        = "10.0.1.0/24" 
  availability_zone = "us-east-1b"
}

# Create a subnet 3
resource "aws_subnet" "ecs_subnet_C" {
  vpc_id            = aws_vpc.ecs_vpc.id
  cidr_block        = "10.0.2.0/24" 
  availability_zone = "us-east-1c"
}

# Create aws route table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.ecs_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}


# association subnet with the route table
resource "aws_route_table_association" "subnet_a_association" {
  subnet_id      = aws_subnet.ecs_subnet_A.id
  route_table_id = aws_route_table.my_route_table.id
}

# association subnet with the route table
resource "aws_route_table_association" "subnet_b_association" {
  subnet_id      = aws_subnet.ecs_subnet_B.id
  route_table_id = aws_route_table.my_route_table.id
}

# association subnet with the route table
resource "aws_route_table_association" "subnet_c_association" {
  subnet_id      = aws_subnet.ecs_subnet_C.id
  route_table_id = aws_route_table.my_route_table.id
}
