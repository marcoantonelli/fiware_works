#Fiware Orion Broker mock test
# Server preparation
## install docker on Ubuntu 14.04 -> http://docs.docker.com/engine/installation/ubuntulinux/

#PREPARE THE ENVIROMENT
## Update your apt sources
$ sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

$ nano /etc/apt/sources.list.d/docker.list
## add the following
$ deb https://apt.dockerproject.org/repo ubuntu-trusty main
## and save

## Update the apt package index
$ apt-get update
## Purge the old repo if it exists
$ apt-get purge lxc-docker*
## Verify that apt is pulling from the right repository
$ apt-cache policy docker-engine
## Install the recommended package
$ sudo apt-get install linux-image-extra-$(uname -r)

# INSTALL DOCKER
## update
$ sudo apt-get update
## Install Docker
$ sudo apt-get install docker-engine
## Verify docker is installed correctly
$ sudo docker run hello-world

# UPGRADE DOCKER
$ apt-get upgrade docker-engine

# FINALIZE INSTALLATION
$ curl -L https://github.com/docker/compose/releases/download/1.5.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
$ chmod +x /usr/local/bin/docker-compose

# INSTALL ORION BROKER ON SERVER
## Create a directory on your system on which to work
$ mkdir fiware_orion
$ cd fiware_orion
## Create a new file called docker-compose.yml inside your directory with the following contents
$ nano docker-compose.yml
## insert the following
mongo: image: mongo:2.6 command: --smallfiles --nojournal orion: image: fiware/orion links: - mongo ports: - "1026:1026" command: -dbhost mongo
## install
$ sudo docker-compose up
## test installation
$ curl localhost:1026/version

# CREATE THE FIRST ENTITY AND RELATIVE ATTRIBUTE (Watly_01 is our Entity, temperature our attribute)
$ curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '
  { "attributes":
    [
      { "name": "temperature",
      "type": "float",
      "value": ""
      }
    ]
  }' 192.168.2.135:1026/v1/contextEntities/Watly_01

## check response
$ curl 192.168.2.135:1026/v1/contextEntities



# ON TEST DEVICE (RASPBERRY PI)
## prepare the device (just follow the instruction on http://www.reuk.co.uk/DS18B20-Temperature-Sensor-with-Raspberry-Pi.htm
## create script directory
$ mkdir fiware_curl_script
$ cd fiware_curl_script
## download the temperature reading script
$ wget https://raw.githubusercontent.com/marcoantonelli/fiware_works/master/shell_curl_temp_loop.sh
## change '28-00000484153d' with your device id (you can find it with $ ls -l /sys/bus/w1/devices/)
## run the script
$ bash shell_curl_temp_loop.sh
