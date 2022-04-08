#Assumptions:

For Actions to run correctly AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY secrets need
to be set in repository secrets settings

Cluster used for deploy is running ALB Ingress so setting up Kubernetes Ingress resource will
configure ALB.
https://aws.amazon.com/premiumsupport/knowledge-center/eks-alb-ingress-controller-fargate/

local.ecosia.org CNAME is pointing to ALB DNS name

To test Actions, i used AWS EKS cluster backed by 4 EC2 instances. 
set up as described in aws-eks directory.

Terraform part is based on [Provision an EKS Cluster learn guide](https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster)
ALB Ingress is alb.sh as a proof of concept for me, should be merged to terraform in next version.
