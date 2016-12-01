apt-get install quagga

sed -i -e 's/zebra=no/zebra=yes/' /etc/quagga/daemons
sed -i -e 's/ospfd=no/ospfd=yes/' /etc/quagga/daemons

cp /vagrant/configs/g2/zebra.conf /etc/quagga
cp /vagrant/configs/g2/ospfd.conf /etc/quagga
chown quagga: /etc/quagga/zebra.conf
chown quagga: /etc/quagga/ospfd.conf
chmod 640 /etc/quagga/zebra.conf
chmod 640 /etc/quagga/ospfd.conf

systemctl enable quagga
systemctl restart quagga

echo "1" > /proc/sys/net/ipv4/ip_forward
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

sed -i -e 's/User=gobgpd/User=quagga/g' /etc/systemd/system/gobgpd.service
systemctl daemon-reload
