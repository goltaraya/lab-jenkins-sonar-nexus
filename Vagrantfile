Vagrant.configure("2") do |config|
  
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.box = "centos/7"
    jenkins.vm.hostname = "jenkins"
    
    jenkins.vm.network "forwarded_port", guest: 80, host: 8080, hostip: "127.0.0.1"
    jenkins.vm.network "forwarded_port", guest: 8091, host: 8091, hostip: "127.0.0.1"
    
    jenkins.vm.network "public_network" # ip: "192.168.56.3"
    
    jenkins.vm.provision "shell", path: "jenkins.sh"
    
    jenkins.vm.provider "virtualbox" do |v|
      v.memory = 2048
    end
  end

  config.vm.define "sonarqube" do |sonarqube|
    sonarqube.vm.box = "centos/7"
    sonarqube.vm.hostname = "sonarqube"
    
    sonarqube.vm.network "forwarded_port", guest: 9000, host: 9000, hostip: "127.0.0.1"
    
    sonarqube.vm.network "public_network" # ip: "192.168.56.4"
    
    sonarqube.vm.provision "shell", path: "sonarqube.sh"
    
    sonarqube.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
  end

end
