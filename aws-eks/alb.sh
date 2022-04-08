#!/bin/bash
#based on https://aws.amazon.com/premiumsupport/knowledge-center/eks-alb-ingress-controller-fargate/

eksctl utils associate-iam-oidc-provider --cluster tree-cluster --approve

#curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.0/docs/install/iam_policy.json
#aws iam create-policy \
#   --policy-name AWSLoadBalancerControllerIAMPolicy \
#   --policy-document file://iam_policy.json

eksctl delete iamserviceaccount --name=aws-load-balancer-controller --cluster=tree-cluster --namespace=kube-system 

eksctl create iamserviceaccount \
  --cluster=tree-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=arn:aws:iam::565116797498:policy/AWSLoadBalancerControllerIAMPolicy \
  --override-existing-serviceaccounts \
  --approve

eksctl get iamserviceaccount --cluster tree-cluster --name aws-load-balancer-controller --namespace kube-system
kubectl get serviceaccount aws-load-balancer-controller --namespace kube-system

helm repo add eks https://aws.github.io/eks-charts
kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"

VPC_ID=`eksctl -v 0 get cluster -n tree-cluster -o yaml | grep vpc | cut -d " " -f 6`

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
    --set clusterName=tree-cluster \
    --set serviceAccount.create=false \
    --set region=eu-central-1 \
    --set vpcId=$VPC_ID \
    --set serviceAccount.name=aws-load-balancer-controller \
    -n kube-system
