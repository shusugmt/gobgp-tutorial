#!env bash

script_dir=$(cd $(dirname $BASH_SOURCE); pwd)
ssh_config=$script_dir/../tmp/ssh_config

[ -f $ssh_config ] || vagrant ssh-config > $ssh_config

for host in r1 r3 r4; do
  patch_file=$script_dir/../configs/${host}.patch
  scp -F $ssh_config $patch_file ${host}:${host}.patch
done
