#!/bin/bash 

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf 
net.bridge.bridge-nf-call-ip6tables = 1 
net.bridge.bridge-nf-call-iptables = 1 
EOF 
sysctl --system 
service docker restart 
apt-get update && apt-get install -y apt-transport-https curl 
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - 
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list 
deb https://apt.kubernetes.io/ kubernetes-xenial main 
EOF 
apt-get update 
apt-get install -y kubelet=1.14.6-00 kubeadm=1.14.6-00  kubectl=1.14.6-00 
apt-mark hold kubelet kubeadm kubectl 
sysctl net.bridge.bridge-nf-call-iptables=1 
