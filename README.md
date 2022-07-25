# POC-L1
# launch instances
- instance type: t2.xlarge
- open all traffic port in Security Group
- select storage of 16GiB

# install jenkins
#!/bin/bash
sudo apt-get update -y
#jenkins
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins

# install java
sudo apt install openjdk-11-jre
java -version

# install maven
sudo apt install maven

# cmd jenkins
- access port 8080
- get password: "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
- move on this PATH manage jenkins/manage plugins/availabel -> install ssh pipeline steps, maven intergration, kubernetes CLI, kubernetes
- move on PATH manage jenkins/ global tool configuration/ -> add PATH of java and maven
- move on PATH manage jenkins/ manage credentials -> add GitHub account and Dockerhub password to assign in pipeline
- create connection kubernetes:
    + sudo cp -r .kube/ .minikube/ /var/lib/jenkins/
    + sudo chown -R jenkins /var/lib/jenkins/.minikube/ /var/lib/jenkins/.kube/
    + sudo nano /var/lib/jenkins/.kube/config
    -> change the PATH according to jenkins PATH (/home/ubuntu/ -> /var/lib/jenkins/ )
    -> test connection: manage jenkins/ manage nodes and clouds -> select kubernetes -> test connect

# install docker
#!/bin/bash
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt install docker-ce
sudo systemctl status docker
sudo usermod -aG docker ${USER}

# cmd docker: 
- "sudo service docker start" to start docker
- "sudo usermod -aG docker jenkins" get permission to run docker cmd


# install helm
#!/bin/bash
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

-> create helm chart: "helm create <name of helm chart>"
-> modify dir templates and file values.yaml
-> create more 1 file istio_ingress to creat gateway and virtual service -> connect microservice and get permission to connect outside

# install minikube and kubectl
#!/bin/bash
sudo apt-get update -y
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version -o json

# cmd minikube
- start minikube: "minikube start --driver=none --kubernetes-version v1.23.8"
- enable the NGINX Ingress controller: "minikube addons enable ingress"
