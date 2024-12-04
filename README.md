This is a demo project for Ben Burbank at American Airlines to show I can program
in Terraform. My plan is to use an AWS VPC in the us-east-1 region and to create
two sub-nets, one public and one private. The public one will have an instance
running a Docker Ubuntu container with a Internet Gateway attached for outside
access. The private one will also have an instance running for a database.

At the moment, this is fluid as I am not sure I can do what I mention.

Here are my assumed steps I need to do:
1) Create a terraform project and populate it with the usual *.tf files:
      - provider.tf     Terraform version and a providers region for aws
      - networking.tf   Create a new VPC and the two subnets, public and private