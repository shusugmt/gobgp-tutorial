# go version to install
export GO_VERSION=1.6.2

# set envvars for go
cat << EOF > /etc/profile.d/golang.sh
export GOROOT=/usr/local/go
export GOPATH=/usr/local/opt/gopath
export PATH=\$GOROOT/bin:\$PATH
EOF

source /etc/profile.d/golang.sh

# install go
mkdir -p $GOPATH
mkdir -p $GOROOT
cd $GOROOT/..
wget https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz > /dev/null 2>&1
tar zxf go${GO_VERSION}.linux-amd64.tar.gz

# install git (required to run go get)
apt-get update
apt-get install -y git

# install gobgp and gobgpd
go get -v github.com/osrg/gobgp/gobgpd
go get -v github.com/osrg/gobgp/gobgp

# install bash completions for gobgp command
cp $GOPATH/src/github.com/osrg/gobgp/tools/completion/*.bash /etc/bash_completion.d/


id gobgpd || useradd -r gobgpd
cp $GOPATH/bin/* /usr/local/sbin
mkdir -p /etc/gobgp
cp /vagrant/prov/gobgpd.service /etc/systemd/system
systemctl daemon-reload
