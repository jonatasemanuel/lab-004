#!/bin/bash

# --- stating final project 004 ---

# criar variavel para nome do projeto/namespace

echo ">>> [1/5] Verificando se o Minikube está de pé..."
# A gente verifica o status. Se não estiver rodando, a gente liga. A gente NÃO DELETA.
if ! minikube status --profile cyber-lab-004 &> /dev/null; then
    echo ">>> iniciando minikube"
    # minikube start --profile cyber-lab-004 --cpus=4 --memory=6144m

    # versao networkpolices
    minikube start --profile cyber-lab-004 --cpus=4 --memory=6144m --network-plugin=cni --cni=calico

else
    echo ">>> minikube ja esta ligado."
fi

minikube profile cyber-lab-004

echo ""
echo ">>> [2/5] ambiente docker minikube"
eval $(minikube -p cyber-lab-004 docker-env)
echo ">>> Conectado. O martelo está na mão."

echo ""
echo ">>> [3/5] k8s - namespace..."
# A gente cria o namespace só se ele não existir.
kubectl create namespace cyber-lab-004 --dry-run=client -o yaml | kubectl apply -f -

echo ""
echo ">>> [4/5] buildando kk atacante"
docker build --network=host -t lab/attacker:1.0 ./attacker-machine/

echo ""
echo ">>> [5/5] k8s aplicanco manifests..."

# kubectl apply -f ./manifests/

kubectl apply -f ./honeypot/honeypot-firewall.yaml
kubectl apply -f ./honeypot/cowrie.yaml

kubectl apply -f ./attacker-machine/attacker-pod.yaml
kubectl apply -f ./attacker-machine/attacker-firewall.yaml

echo ""
echo ">>> show"
