# data "aws_ami" "optimized_linux_ecs" {
#   most_recent = true
#   filter {
#     name = "name"
#     #values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
#     values = ["al2023-ami-ecs-hvm-2023.0.20241217-kernel-6.1-x86_64"]
#     #values = ["amzn2-ami-ecs-hvm-2.0.20241120-x86_64-ebs"] # As per aws ssm command from DCT
#   }
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

# resource "aws_ecs_service" "aws_ecs_aa" {
#   name = "aws_ecs_aa"

#   #Research here for Terraform arguments to create a single ECS container.
#   #Keeping it simple (default countiners=1)

#   tags = merge(local.common_tags, {
#     Name = "AWS_ECS_AA"
#   })
# }

# #Define a cluster - NOTE ECS IS NOT ACCEPTING MY EXTERNAL EC2 INSTANCE!! This is because
# #DCT is not correct in it's HOL and I cannot move further.
# resource "aws_ecs_cluster" "aws_ecs_cluster_aa" {
#   name = "aws_ecs_cluster_aa"

#   tags = merge(local.common_tags, {
#     Name = "AWS_CLUSTER_AA"
#   })
# }

# Create the ECS Optimized instance
# resource "aws_instance" "optimized_ecs" {
#   ami             = data.aws_ami.ubuntu.image_id
#   instance_type   = "t2.micro"
#   key_name        = "ECS-PEM-KEY-PAIR"
#   subnet_id       = aws_subnet.subnet_public_aa.id
#   security_groups = [aws_security_group.test_port_22.id]
# }


# output "ecs_optimized_info" {
#   value = <<EOF
# Optimized Instance ID: ${data.aws_ami.optimized_linux_ecs.image_id},
# Optimized Instance Name: ${data.aws_ami.optimized_linux_ecs.name},
# Opt Instance Description: ${data.aws_ami.optimized_linux_ecs.description},
# Opt Instance Owner Alias: ${data.aws_ami.optimized_linux_ecs.image_owner_alias}
# EOF
# }
