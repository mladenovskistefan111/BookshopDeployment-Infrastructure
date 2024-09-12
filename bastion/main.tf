# --- bastion/main.tf

data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*.1"]
  }
}

resource "aws_security_group" "bastion_security_group" {
  name        = "bastion_security_group"
  description = "Security group for Bastion"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_key_pair" "bastion_key" {
#   key_name   = "bastion-key"
#   public_key = var.public_key_path
# }

resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion-key"
  public_key = var.ssh_public_key
}

resource "aws_instance" "bastion" {
  ami             = data.aws_ami.server_ami.id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.bastion_key.id
  security_groups = [aws_security_group.bastion_security_group.id]
  subnet_id       = var.public_subnet

  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }

  tags = {
    Name = "BastionHost"
  }

  lifecycle {
    create_before_destroy = true
  }
}
