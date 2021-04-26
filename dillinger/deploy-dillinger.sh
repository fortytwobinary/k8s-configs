#!/bin/bash
# Script to deploy Dillinger in the nodeport namespace

kubectl apply -f dillinger-deploy.yaml -n nodeport
kubectl expose deploy dillinger --type=NodePort -n nodeport

NODEPORT=$(kubectl get svc -n nodeport | grep dillinger | awk '{print $5}' | awk -F':' '{print $2}' | awk -F'/' '{print $1}')

echo Dillinger is now deployed internally at 192.168.1.18:$NODEPORT \
