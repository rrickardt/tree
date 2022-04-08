This repository contains simple Flask webapp to serve json on GET request with its requirements.txt and
Dockerfile used to build container for ECR registry. Actions do the following steps on push or pull request to main branch:

- build container and upload it to ECR
- customize image with name based in Kubernetes deployment manifest using kustomize
- deploy manifests with kubectl
- kubectl get ingress tree-ingress -o wide should provide endpoint address, only /tree path returns json.

##  Assumptions
For Actions to run correctly AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY secrets need
to be set in repository secrets settings

In order to app be reachable on local.ecosia.org/tree, local.ecosia.org CNAME should point to ALB DNS name

Cluster used for app deployment should use ALB Ingress so setting up Kubernetes Ingress resource will
configure ALB.
https://aws.amazon.com/premiumsupport/knowledge-center/eks-alb-ingress-controller-fargate/

## Test infrastructure
To test Actions, i used AWS EKS cluster backed by 4 EC2 instances.
Terraform part is based on [Provision an EKS Cluster learn guide](https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster)
ALB Ingress is alb.sh as a proof of concept for me, should be merged to terraform in next version.
