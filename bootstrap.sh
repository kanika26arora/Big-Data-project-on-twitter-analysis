vagrant provision

cd /vagrant
sudo mkdir /usr/local/java
sudo cp -r jdk-8u101-linux-x64.tar.gz /usr/local/java/
cd /usr/local/java
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