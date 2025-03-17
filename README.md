1. REAL TIME ANALYTICS WITH APACHE STORM - COMPONENTS
    •	We use visualization technology vagrant cloud and Virtual Box. Using Git and Vagrant commands we launch a virtual machine, the open source Linux Distribution Ubuntu. We then use the Java build tool Maven to explore real time analytics with Apache Storm.
    •	We also use the programming languages Python and Java along with the packages Beautiful Soup and Lettuce to connect to the python micro server Flask. And the in-memory key-value store Redis to finally drive real time visualizations using D3 written in JavaScript.
    •	In Storm, we will explore concepts like Spout, a bolt and a connecting called a topology. These components are written in both Java and Python and finally connected to Twitter sample stream using the open API Twitter4J. We will also explore more complex topologies using streaming joins.
    •	The programming language Clojure is the language in which most of Storm is written in.
    •	An actual cluster administration is there to submit Storm topology in.
    •	Ack which allows the at least once processing.

2. INSTALLATION AND CONFIGURATION

   2.1 SOFTWARE INSTALLATION 
         Install Git from https://git-for-windows.github.io/ and install it choosing “Use git from windows command prompt”. 
         Download VirtualBox from https://www.virtualbox.org/wiki/Downloads and install it.
         Download vagrant box from https://releases.hashicorp.com/vagrant/1.8.5/vagrant_1.8.5.msi and install it.
         Write ‘vagrant up’ command in command prompt and we are good to go.

     2.2 SOFTWARE CONFIGURATION
             Vagrant is used as it isolate dependencies and their configuration within a single disposable, consistent environment, without sacrificing any of the tools we are used to working with (editors, browsers, debuggers, etc.). We created a single Vagrantfile and then we just needed to vagrant up and everything is installed and configured to work. Other members of the team create their development environments from the same configuration, so whether we are working on Linux, Mac OS X, or Windows, all the team members are running code in the same environment, against the same dependencies, all configured the same way. Say goodbye to "works on my machine" bugs. This is how Vagrant benefits us.


# **VagrantFile:**

mode: ruby 
vi: set ft=ruby :

All Vagrant configuration is done below. The "2" in Vagrant.configure 
configures the configuration version (we support older styles for
backwards compatibility). Please don't change it unless you know what
you're doing.

Vagrant.configure("2") do |config|

The most common configuration options are documented and commented below.
For a complete reference, please see the online documentation at
https://docs.vagrantup.com.

Every Vagrant development environment requires a box. You can search for
boxes at https://atlas.hashicorp.com/search.
name of the box:
config.vm.box = "hashicorp/precise64"
config.vm.box_version = "1.1.0"
http address of the box
 config.vm.box_url = "https://atlas.hashicorp.com/hashicorp/boxes/precise64/versions/1.1.0/providers/virtualbox.box"
 config.vm.network :forwarded_port, guest: 5000, host: 5000
 config.vm.provision :shell, path: "bootstrap.sh"

Disable automatic box update checking. If you disable this, then
boxes will only be checked for updates when the user runs
`vagrant box outdated`. This is not recommended.
config.vm.box_check_update = false

 Create a forwarded port mapping which allows access to a specific port
 within the machine from a port on the host machine. In the example below,
 accessing "localhost:8080" will access port 80 on the guest machine.
 config.vm.network "forwarded_port", guest: 80, host: 8080

 Create a private network, which allows host-only access to the machine
 using a specific IP.
 config.vm.network "private_network", ip: "192.168.33.10"

 Create a public network, which generally matched to bridged network.
 Bridged networks make the machine appear as another physical device on
 your network.
 config.vm.network "public_network"

 Share an additional folder to the guest VM. The first argument is
 the path on the host to the actual folder. The second argument is
 the path on the guest to mount the folder. And the optional third
 argument is a set of non-required options.
 config.vm.synced_folder "../data", "/vagrant_data"

 Provider-specific configuration so you can fine-tune various
 backing providers for Vagrant. These expose provider-specific options.
 Example for VirtualBox:

 config.vm.provider "virtualbox" do |vb|
    Display the VirtualBox GUI when booting the machine
   vb.gui = true

Customize the amount of memory on the VM:
vb.memory = "1024"
end

 View the documentation for the provider you are using for more
 information on available options.

 Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
 such as FTP and Heroku are also available. See the documentation at
 https://docs.vagrantup.com/v2/push/atlas.html for more information.
 config.push.define "atlas" do |push|
   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
 end

 Enable provisioning with a shell script. Additional provisioners such as
 Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
 documentation for more information about their specific syntax and use.
 config.vm.provision "shell", inline: <<-SHELL
   apt-get update
   apt-get install -y apache2
 SHELL
end

Here, the  config.vm.provision command is used to run any configured provisioners against the running Vagrant managed machine. So, according to the path mentioned bootstrap.sh will run.
Bootstrap.sh is a shell scripting file which holds commands to download, extract and install all the tools like maven, jdk, connection to flask, zookeeper framework, apache storm etc.
So, once we type the command ‘vagrant up’ in command prompt, VagrantFile is executed from which vagrant box starts which are nothing but a base image to quickly clone a virtual machine and provision command will direct the system to run bootstap.sh and the rest of the softwares will be downloaded.

# **Bootstrap.sh:**

sudo tar xvzf jdk-8u101-linux-x64.tar.gz

sudo sh -c "echo 'JAVA_HOME=/usr/local/java/jdk1.8.0_101' >> /etc/profile"

sudo sh -c "echo 'JRE_HOME=/usr/local/java/jdk1.8.0_101/jre' >> /etc/profile"

sudo sh -c "echo 'PATH=$PATH:/usr/local/java/jdk1.8.0_101/jre/bin:$/usr/local/java/jdk1.8.0_101/bin' >> /etc/profile"

sudo sh -c "echo 'export JAVA_HOME' >> /etc/profile"

sudo sh -c "echo 'export JRE_HOME' >> /etc/profile"

sudo sh -c "echo 'export PATH' >> /etc/profile"

sudo update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jdk1.8.0_ 101/bin/java" 1

sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/jdk1.8. 0_101/bin/javac" 1

sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/local/java/jdk1. 8.0_101/bin/javaws" 1

sudo update-alternatives --set java /usr/local/java/jdk1.8.0_101/bin/java

sudo update-alternatives --set javac /usr/local/java/jdk1.8.0_101/bin/javac

sudo update-alternatives --set javaws /usr/local/java/jdk1.8.0_101/bin/javaws

source /etc/profile

cd /opt

sudo wget "http://mirror.fibergrid.in/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz"

sudo tar xzvf apache-maven-3.3.9-bin.tar.gz

sudo rm apache-maven-3.3.9-bin.tar.gz

echo 'export PATH=/opt/apache-maven-3.3.9/bin:$PATH' >> ~/.profile

sudo apt-get -y install vim zookeeper zookeeperd redis-server \

python-software-properties python-pip python tree python-bs4

sudo pip install flask redis

sudo mkdir /opt/storm

cd /opt/storm

sudo wget http://mirror.fibergrid.in/apache/storm/apache-storm-1.0.2/apache-storm-1.0.2.tar.gz

sudo tar xvzf apache-storm-1.0.2.tar.gz

sudo rm apache-storm-1.0.2.tar.gz

sudo chmod +x /opt/storm/apache-storm-1.0.2/bin/storm

sudo ln -s /opt/storm/apache-storm-1.0.2/bin/storm /usr/bin/storm
















