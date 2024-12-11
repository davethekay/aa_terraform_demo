# resource "aws_ecs_service" "aws_ecs_aa" {
#      name = "aws_ecs_aa"

#   #Research here for Terraform arguments to create a single ECS container.
#   #Keeping it simple (default countiners=1)

#       tags = merge(local.common_tags, {
#             Name = "AWS_ECS_AA"
#       })
# }

# Define a cluster
resource "aws_ecs_cluster" "aws_ecs_cluster_aa" {
  name = "aws_ecs_cluster_aa"

  tags = merge(local.common_tags, {
    Name  = "AWS_CLUSTER_AA"
  })
}