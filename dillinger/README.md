# dillinger

This README.md is part of a set of folders within the k8s-configs repo at https://github.com/fortytwobinary. The following instructions describe how I deployed Dillinger on my K8s cluster and created a NodePort service to provide a nice markdown editor on my internal network for markdown editing and the ability to keep this content from the public internet (NodePort).

I created a dillinger-deploy.yaml that you will find within this repo. Very simply deployed with:
```bash
kubectl create namespace nodeport
kubectl apply -f dillinger-deploy.yaml
kubectl expose deploy dillinger --type=NodePort --name=dillinger -n nodeport
```
That's it! Note that I created a nodeport namespace. From here on out I will put NodePort services there. This way all internal-only accessible services will be in one place.

Get the services for the nodeport namespace.
```bash
kubectl get svc -n nodeport
```
Use the output to obtain the port number for the NodePort service. This means that any K8s node IP can be used with this port number to access Dillinger.
```bash
ubuntu@kube-master:~/k8s-configs/dillinger$ kubectl get svc -n nodeport
NAME        TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
dillinger   NodePort   10.103.125.128   <none>        8080:30925/TCP   11m
```
Get a wide output from `get nodes` and you have the IPs of your nodes.
```bash
kubectl get nodes -o wide

ubuntu@kube-master:~/k8s-configs/dillinger$ kubectl get nodes -o wide
NAME            STATUS   ROLES                  AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION     CONTAINER-RUNTIME
kube-master     Ready    control-plane,master   33d   v1.20.5   192.168.1.12   <none>        Ubuntu 20.04.2 LTS   5.4.0-1028-raspi   docker://19.3.8
kube-worker-1   Ready    <none>                 33d   v1.20.5   192.168.1.18   <none>        Ubuntu 20.04.2 LTS   5.4.0-1030-raspi   docker://19.3.8
kube-worker-2   Ready    <none>                 33d   v1.20.5   192.168.1.17   <none>        Ubuntu 20.04.2 LTS   5.4.0-1028-raspi   docker://19.3.8
kube-worker-3   Ready    <none>                 33d   v1.20.5   192.168.1.19   <none>        Ubuntu 20.04.2 LTS   5.4.0-1030-raspi   docker://19.3.8
kube-worker-4   Ready    <none>                 33d   v1.20.5   192.168.1.14   <none>        Ubuntu 20.04.2 LTS   5.4.0-1030-raspi   docker://19.3.8
```


