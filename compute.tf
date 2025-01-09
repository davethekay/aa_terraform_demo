# Data block for choosing an AMI instance from Amazon
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["137112412989"] # Owner is Canonical
  
  filter {
    name   = "name"
    values = ["al2023-ami-2023.6.20241111.0-kernel-6.1-x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Display the following info for the AMI (Free Tier) that was selected
# (NOTE: there is no info from the data block that can say whether an AMI is free tier or not)
output "ami_instance" {
  value = <<EOF
  "Instance ID: ${data.aws_ami.ubuntu.id},
  \nInstance Description: ${data.aws_ami.ubuntu.description},
  \nInstance Owner Alias: ${data.aws_ami.ubuntu.image_owner_alias}"
  EOF
}

# Create a standard Linux instance using the subnet_public_aa subnet
resource "aws_instance" "instance_public_aa" {
  ami             = data.aws_ami.ubuntu.image_id
  instance_type   = "t2.micro"
  key_name        = "ECS-PEM-KEY-PAIR"
  subnet_id       = aws_subnet.subnet_public_aa.id
  security_groups = [aws_security_group.aws_sg_public_22_80_443_aa.id]
}
