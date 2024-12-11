# Data block for choosing an AMI instance from Amazon
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["137112412989"] # Owner is Canonical
  # provider = "xx-xxxx-x"

  filter {
    name = "name"
    #values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
    values = ["al2023-ami-2023.6.20241111.0-kernel-6.1-x86_64"]
    #values = ["amzn2-ami-ecs-hvm-2.0.20241120-x86_64-ebs"] # As per aws ssm command from DCT
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# There is a keyword called "user_data" for having an instance run a script to do setup tasks
#

# Display the following info for the AMI (Free Tier) that was selected
# (NOTE: there is no info from the data block that can say whether an AMI is free tier or not)
output "ami_instance" {
  value = <<EOF
  "Instance ID: ${data.aws_ami.ubuntu.image_id}, 
  \nImage location: ${data.aws_ami.ubuntu.image_location},
  \ndescription: ${data.aws_ami.ubuntu.description}"
  EOF
}

#Create a Linux instance using the subnet_public_aa subnet
resource "aws_instance" "instance_public_aa" {
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_public_aa.id
  user_data     = <<EOF
  #!/bin/bash
  echo ECS_CLUSTER=${var.aws_cluster_name_aa} >> /etc/ecs/ecs.config
  EOF
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
  security_groups = [aws_security_group.aws_sg_public_22_80_aa.id]
}
