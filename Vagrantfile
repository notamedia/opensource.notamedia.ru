Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :file, source: "~/.gitconfig", destination: ".gitconfig"
  #config.vm.provision :shell, path: "./install.bash"
  #config.vm.provision :shell, path: "./install2.bash"

  config.vm.network "forwarded_port", guest: 4000, host: 4000, auto_correct: true

  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  config.ssh.forward_agent = true

end
