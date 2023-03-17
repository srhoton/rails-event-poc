resource "aws_security_group" "rails_dest_inbound" {
  name = "rails_dest_inbound"
  vpc_id = module.default_network.vpc_id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0 
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "rails_dest_inbound"
  }
}

resource "aws_instance" "rails_dest_instance" {
  ami = "ami-0557a15b87f6559cf"
  instance_type = "t3.micro"
  associate_public_ip_address = true

  subnet_id = module.default_network.public_subnet_list[1]
  vpc_security_group_ids = [aws_security_group.rails_dest_inbound.id]
  key_name = "b2c"

  tags = {
    Name = "rails_dest_instance"
  }
}
