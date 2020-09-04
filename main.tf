provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "amzn2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*-x86_64-gp2"]
  }
}

### Bastion
resource "aws_security_group" "bastion" {
  name = "${var.environment}-Bastion-TEMP-MIGRATION"
  description = "Allows Connections to the ${var.environment} Bastion Instance"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ips
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment} Bastion Instance"
    Environment = var.environment
  }
}

resource "aws_eip" "bastion" {
  instance = aws_instance.bastion.id
  vpc      = true
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.amzn2.id
  instance_type               = "t3.small"
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  associate_public_ip_address = "true"

  root_block_device {
    volume_size           = "100"
    volume_type           = "gp2"
    delete_on_termination = "false"
    encrypted             = "true"
  }

  tags = {
    Name        = "${var.environment}-Bastion-TEMP-MIGRATION"
    Environment = var.environment
  }

  volume_tags = {
    Name        = "${var.environment}-Bastion-TEMP-MIGRATION"
    Environment = var.environment
  }
}
