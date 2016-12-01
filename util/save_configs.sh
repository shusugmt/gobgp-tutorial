#!env bash

script_dir=$(cd $(dirname $BASH_SOURCE); pwd)
root_dir=$script_dir/../
ssh_config=$root_dir/tmp/ssh_config

[ -f $ssh_config ] || vagrant ssh-config > $ssh_config

for host in r1 r3 r4; do
  ssh -F $ssh_config $host cli show configuration \\\| compare initial_config > $root_dir/configs/${host}.patch
done

ssh -F $ssh_config g2 "cat << EOF | bash -e
  sudo cp /etc/quagga/zebra.conf /vagrant/configs/g2/
  sudo cp /etc/quagga/ospfd.conf /vagrant/configs/g2/
EOF
"
