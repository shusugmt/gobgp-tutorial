cp /vagrant/configs/rs.gobgpd.conf /etc/gobgp/gobgpd.conf
systemctl enable gobgpd
systemctl start gobgpd
