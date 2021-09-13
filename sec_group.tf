#security group that accomplishing the following items: 
#1.Any traffic orginating from our home IP (will require further investigation)
#2. Any inbound rules required for HC Vault (need to research)
#3.SSH traffic over port 9022 

resource "aws_security_group" "allow-ssh" {
  vpc_id = aws_vpc.main.id
  name = "alllow-ssh"
  description = "security group that allows ssh and all egress traffic"
  egress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    protocol = "-1"
    self = false
    to_port = 0
  } ]

  ingress {
    from_port = 9022
    to_port = 9022
    protocol ="tcp"
    cidr_blocks =["0.0.0.0/0"]
    }
  tags {
    Name = "allow-ssh"
    Meta ="$lookup{var.tag_template}"
  }

}