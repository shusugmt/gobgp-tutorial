Vagrant.configure(2) do |config|
  # g2 (GoBGP)
  config.vm.define :g2 do |g2|
    g2.vm.box = "bento/debian-8.5"
    g2.vm.box_version = "< 2.3.0"
    g2.vm.network "private_network", ip: "10.254.0.102",   virtualbox__intnet: "gobgp-t_util"
    g2.vm.network "private_network", ip: "10.173.176.102", virtualbox__intnet: "gobgp-t_ix"
    g2.vm.network "private_network", ip: "10.1.12.102",    virtualbox__intnet: "gobgp-t_1-to-2"
    g2.vm.provider "virtualbox" do |v|
      v.cpus = 2
      v.memory = 1024
    end
    g2.vm.provision "shell", privileged: true, inline: <<-EOS
      grep 127.0.1.2 /etc/hosts || echo 127.0.1.2 g2 >> /etc/hosts
      hostnamectl set-hostname g2
      systemctl restart rsyslog
    EOS
    g2.vm.provision "shell", privileged: true, path: "prov/install_gobgp.sh"
    g2.vm.provision "shell", privileged: true, path: "prov/setup_g2.sh"
  end

  # r1 junos
  config.vm.define :r1 do |r1|
    r1.vm.box = "juniper/ffp-12.1X47-D15.4-packetmode"
    r1.vm.network "private_network", ip: "10.1.12.101",  virtualbox__intnet: "gobgp-t_1-to-2"
    r1.vm.network "private_network", ip: "10.1.14.101",  virtualbox__intnet: "gobgp-t_1-to-4"
  end

  # r3 junos
  config.vm.define :r3 do |r3|
    r3.vm.box = "juniper/ffp-12.1X47-D15.4-packetmode"
    r3.vm.network "private_network", ip: "10.173.176.103", virtualbox__intnet: "gobgp-t_ix"
  end

  # r4 junos
  config.vm.define :r4 do |r4|
    r4.vm.box = "juniper/ffp-12.1X47-D15.4-packetmode"
    r4.vm.network "private_network", ip: "10.1.14.104",  virtualbox__intnet: "gobgp-t_1-to-4"
  end

  config.vm.define :rs do |rs|
    rs.vm.box = "bento/debian-8.5"
    rs.vm.box_version = "< 2.3.0"
    rs.vm.network "private_network", ip: "10.173.176.211", virtualbox__intnet: "gobgp-t_ix"
    rs.vm.provider "virtualbox" do |v|
      v.cpus = 2
      v.memory = 1024
    end
    rs.vm.provision "shell", privileged: true, inline: <<-EOS
      grep 127.0.1.2 /etc/hosts || echo 127.0.1.2 rs >> /etc/hosts
      hostnamectl set-hostname rs
      systemctl restart rsyslog
    EOS
    rs.vm.provision "shell", privileged: true, path: "prov/install_gobgp.sh"
    rs.vm.provision "shell", privileged: true, path: "prov/setup_rs.sh"
  end

  config.vm.define :util do |util|
    util.vm.box = "bento/debian-8.5"
    util.vm.box_version = "< 2.3.0"
    util.vm.network "private_network", ip: "10.254.0.250",   virtualbox__intnet: "gobgp-t_util"
    util.vm.provider "virtualbox" do |v|
      v.cpus = 2
      v.memory = 1024
    end
    util.vm.provision "shell", privileged: true, inline: <<-EOS
      grep 127.0.1.2 /etc/hosts || echo 127.0.1.2 util >> /etc/hosts
      hostnamectl set-hostname util
      systemctl restart rsyslog
    EOS
  end

end
