resource "aws_security_group" "aws_sg_public_22_80_aa" {
  name        = "aws_sg_public_ssh_http_aa"
  description = "Security group for using ports 80 and 22"
  vpc_id      = aws_vpc.vpc_main_aa.id
  ingress {
    description = "Allow access to port 22 of an EC2 Instance"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow access to port 80 of an EC2 Instance"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = ""
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }

  tags = merge(local.common_tags, {
  Name = "AWS_SG_PUBLIC_SSH_HTTP_AA" })
}