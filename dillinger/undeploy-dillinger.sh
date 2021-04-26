#!/bin/bash
# Script to undeploy Dillinger

kubectl delete svc dillinger -n nodeport
kubectl delete deploy dillinger -n nodeport
