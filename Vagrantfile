# Vagrantfile to create images that run Puppet Scripts

Vagrant.configure("2") do |config|

  ips = {
    :puppet_sshHost => "10.10.20.9",
  }

  box_names = {
    :puppet_sshHost => "xl_precise32",
  }

  box_urls = {
    :puppet_sshHost => "http://tech.xebialabs.com/xebialabs-vagrant/xl_precise32.box",
  }

   [:puppet_sshHost].collect do |version|
    config.vm.define version do |puppet_sshHost_config|
      puppet_sshHost_config.vm.box = box_names[version]
      puppet_sshHost_config.vm.box_url = box_urls[version]
      puppet_sshHost_config.vm.network :private_network, ip: ips[version]

      puppet_sshHost_config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "4096"]
        vb.customize ["modifyvm", :id, "--name", ENV['VM_PREFIX'].to_s + version.to_s]
      end

      puppet_sshHost_config.vm.provision :shell, :path => "scripts/puppet.sh"

      if Vagrant.has_plugin?("vagrant-cachier")
        puppet_sshHost_config.cache.auto_detect = false
        puppet_sshHost_config.cache.scope = :machine
        puppet_sshHost_config.cache.enable :apt
        puppet_sshHost_config.cache.enable :gem
      end
    end
  end
end
