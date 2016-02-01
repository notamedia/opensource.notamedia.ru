VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.network "forwarded_port", guest: 80, host: 8182, auto_correct: true
  #config.vm.synced_folder "./", "/var/www"
  config.ssh.forward_agent = true
end

#
# sudo -i
# echo "nameserver 8.8.8.8" > /etc/resolv.conf
# apt-get update
# apt-get install -y nginx
# rm /usr/share/nginx/www
# ln -s /vagrant /usr/share/nginx/www
# service nginx restart
#