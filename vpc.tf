#VPC Public
#Internet VPC 

resource "aws_vpc" "main"{
    cidr_block ="10.0.0.0/16"
    instance_tenancy ="default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        name = "main"
        Meta ="$lookup{var.tag_template}"
    }
}

#Subnets
resource "aws_subnet" "main-public-1" {
    vpc_id ="${aws_vpc.main.od}"
    cidr_block ="10.0.1.0/24"
    map_public_ip_on_launch="true"
    availability_zone = "us-east-1a"

    tags {
            name = "main-public-1"
            Meta ="$lookup{var.tag_template}"
    }
}
resource "aws_subnet" "main-public-2" {
    vpc_id ="${aws_vpc.main.od}"
    cidr_block ="10.0.2.0/24"
    map_public_ip_on_launch="true"
    availability_zone = "us-east-1b"

    tags {
            name = "main-public-2"
            Meta ="$lookup{var.tag_template}"
    }    
}
resource "aws_subnet" "main-public-3"{
   vpc_id ="${aws_vpc.main.od}"
    cidr_block ="10.0.3.0/24"
    map_public_ip_on_launch="true"
    availability_zone = "us-east-1c"

    tags {
            name = "main-public-3"
            Meta ="$lookup{var.tag_template}"
    }
}
resource  "aws_subnet" "main-private-1" {
    vpc_id ="${aws_vpc.main.od}"
    cidr_block ="10.0.4.0/24"
    map_public_ip_on_launch="false"
    availability_zone = "us-east-1a"

    tags {
            name = "main-private-1"
            Meta ="$lookup{var.tag_template}"
    }        
}
resource "aws_subnet" "main-private-2" {
    vpc_id ="${aws_vpc.main.od}"
    cidr_block ="10.0.5.0/24"
    map_public_ip_on_launch="false"
    availability_zone = "us-east-1b"

    tags {
            name = "main-private-2"
            Meta ="$lookup{var.tag_template}"
    }   
}
resource "aws_subnet" "main-private-3" {
    vpc_id ="${aws_vpc.main.od}"
    cidr_block ="10.0.6.0/24"
    map_public_ip_on_launch="false"
    availability_zone = "us-east-1c"

    tags {
            name = "main-private-3"
            Meta ="$lookup{var.tag_template}"
    }   
}             
# Internet GW
resource "aws_route_table" "main-public" {
    vpc_id ="${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main-gw.id}"
    }
    tags {
        name = "main-private-3"
        Meta ="$lookup{var.tag_template}"
    }   
}
# route associations public 
resource "aws_route_table_association" "main-public-1-a" {
    subnet_id ="${aws_subnet.main-public-1.id}"
    route_table_id = "${aws_route_table.main-public.iud}"
}
resource "aws_route_table_association" "main-public-2-a" {
    subnet_id ="${aws_subnet.main-public-2.id}"
    route_table_id = "${aws_route_table.main-public.iud}"
}
resource "aws_route_table_association" "main-public-3-a" {
    subnet_id ="${aws_subnet.main-public-3.id}"
    route_table_id = "${aws_route_table.main-public.iud}"
}