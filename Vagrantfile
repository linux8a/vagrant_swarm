# -*- mode: ruby -*-
# vi: set ft=ruby :

## vagrant parameters
# Use this BOX bento/ubuntu-20.04

BOX = "bento/ubuntu-20.04"

##     Proxy and port
##     If you do not use proxy, leave empty what is in quotesif not use proxy
##   Examples
# PROXY_IP =  ""
# PROXY_PORT = ""
# 
## You use proxy
# PROXY_IP =  "192.0.0.1"
# PROXY_PORT = "8080"
#############################################

PROXY_IP =  "192.0.0.1"
PROXY_PORT = "3128"

# master node parameters set IP RAM and CPU
MANAGER_IP = "10.8.100.10"
MANAGER_CPU = "1"
MANAGER_RAM = "2048"
# node parameters set  RAM and CPU
WORKER_IP = "10.8.100."
WORKER_CPU = "1"
WORKER_RAM = "1024"
# Number node create
WORKER_COUNT = 2

## general vagrant configurations
Vagrant.configure("2") do |config|
  config.vm.box = BOX
  config.vm.box_check_update = false
  config.vm.provision "shell", :path => "provision/provision_base.sh",
    env: {
        "PROXY_IP" => PROXY_IP,
        "PROXY_PORT" => PROXY_PORT
      }

  # master node configuration
  config.vm.define "manager" do |manager|
    manager.vm.hostname = "manager"
    manager.vm.network "private_network", ip: MANAGER_IP
    manager.vm.network "public_network", bridge: "wlan0"
    manager.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--cpus", MANAGER_CPU]
      vb.customize ["modifyvm", :id, "--memory", MANAGER_RAM]
    end
    manager.vm.provision :shell, :path => "provision/manager.sh",
      env: {
        "MANAGER_IP" => MANAGER_IP
      }
  end

  # node configuration
  (1..WORKER_COUNT).each do |i|
    config.vm.define "worker#{i}" do |worker|
      worker.vm.hostname = "worker#{i}"
      worker.vm.network "private_network", ip: WORKER_IP + "#{i + 10}"
      worker.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--cpus", WORKER_CPU]
        vb.customize ["modifyvm", :id, "--memory", WORKER_RAM]
      end
      worker.vm.provision :shell, :path => "provision/worker.sh",
      env: {
        "MANAGER_IP" => MANAGER_IP
      }
    end
  end
end