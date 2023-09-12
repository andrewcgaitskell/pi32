# pi32

# not working!!

## install latest go

### thank you to :
https://www.jeremymorgan.com/tutorials/raspberry-pi/install-go-raspberry-pi/

## script
    sudo su
    
    mkdir /software && cd /software
    visit https://go.dev/dl/
    copy link to latest package - right click required package
    wget https://go.dev/dl/go1.21.1.linux-amd64.tar.gz
    extract package
    tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz
    nano ~/.profile
    paste
    PATH=$PATH:/usr/local/go/bin
    GOPATH=$HOME/go
    save
    source ~/.profile
    go version
    exit su
    exit
    repeat for local user
    nano ~/.profile
    paste
    PATH=$PATH:/usr/local/go/bin
    GOPATH=$HOME/go
    save
    source ~/.profile
    go version

## installing latest podman

## thank you to:
https://computingforgeeks.com/how-to-install-podman-on-debian-linux/
    
    sudo su
    apt update && sudo apt upgrade -y
    apt install btrfs-progs git iptables libassuan-dev libbtrfs-dev libc6-dev libdevmapper-dev \
    libglib2.0-dev libgpgme-dev libgpg-error-dev libprotobuf-dev libprotobuf-c-dev  libseccomp-dev \
    libselinux1-dev libsystemd-dev pkg-config runc uidmap make curl vim gcc -y
    
    cd /software
    git clone https://github.com/containers/conmon
    cd conmon
    export GOCACHE="$(mktemp -d)"
    make
    sudo make podman
    
    cd /software
    git clone https://github.com/opencontainers/runc.git $GOPATH/src/github.com/opencontainers/runc
    cd $GOPATH/src/github.com/opencontainers/runc
    make BUILDTAGS="selinux seccomp"
    cp runc /usr/bin/runc
    
    runc --version
    
    mkdir -p /etc/containers
    curl -L -o /etc/containers/registries.conf https://src.fedoraproject.org/rpms/containers-common/raw/main/f/registries.conf
    curl -L -o /etc/containers/policy.json https://src.fedoraproject.org/rpms/containers-common/raw/main/f/default-policy.json
    
    apt install -y libapparmor-dev libsystemd-dev


    apt install catatonit ## required for infra containers
    apt-get install autoconf
    
    apt install slirp4netns ## required for rootless networking

    cd /sofware
    wget https://github.com/rootless-containers/slirp4netns/archive/refs/tags/v1.2.1.tar.gz
    tar xvf v1.2.1.tar.gz
    Make the file executable:

    chmod +x slirp4netns

    Copy the binary file to your $PATH:
    
    sudo cp slirp4netns /usr/local/bin
    
    install podman
    
    apt install curl wget -y
    
    visit https://github.com/containers/podman/releases
    
    cd /software
    wget https://github.com/containers/podman/archive/refs/tags/v4.6.1.tar.gz
    tar xvf v4.6.1.tar.gz
    
    cd podman*/
    make BUILDTAGS="selinux seccomp"
    make install PREFIX=/usr
    
    podman version

