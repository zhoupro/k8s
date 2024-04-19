#!/usr/bin/env bash
echo "install k8s env"

# #docker devevlop enviroment
dockerenv(){
    if (( $( which docker | wc -l)==0 )) ;then
        curl -sSL https://get.daocloud.io/docker | sh
        sudo service docker start
        sudo groupadd docker
        sudo usermod -aG docker $uname
    fi

    if (( $( which docker-compose | wc -l)==0 )) ;then
        pip install -U docker-compose
    fi
    sudo mkdir -p /etc/docker
    sudo tee /etc/docker/daemon.json <<-'EOF'
    {
    "registry-mirrors": ["https://pg3p5mmo.mirror.aliyuncs.com"]
    }
EOF
    sudo systemctl daemon-reload
    sudo systemctl restart docker

}

sudo apt install -y python3-pip

# dockerenv
function k8s_ins(){
	# docker
	if ! dpkg -l | grep -q "docker-ce" ; then
		sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
		sudo curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
		sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
		sudo apt update
		sudo apt-get -y install docker-ce
	fi


# 	if ! dpkg -l | grep -q "kubectl" ; then
# 		sudo apt-get update && sudo apt-get install -y apt-transport-https
# 		sudo curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo  apt-key add - 
# 		cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
# 		deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
# EOF
# 		sudo apt-get update
# 		sudo apt-get install -y kubelet kubeadm kubectl
         
# 	fi
}

k8s_ins
