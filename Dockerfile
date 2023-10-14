# Firefox over VNC
#
# VERSION               0.1
# DOCKER-VERSION        0.2

from	f69m/ubuntu32:16.04

# make sure the package repository is up to date
run	echo "deb http://archive.ubuntu.com/ubuntu xenial main universe" > /etc/apt/sources.list
run	apt-get update

# Install vnc, xvfb in order to create a 'fake' display and firefox
run	apt-get install -y x11vnc xvfb openbox 

# Install the specific tzdata-java we need
run     apt-get -y install wget
run     wget --no-check-certificate http://archive.ubuntu.com/ubuntu/pool/main/t/tzdata/tzdata_2021a-0ubuntu0.16.04_all.deb
run     dpkg -i tzdata_2021a-0ubuntu0.16.04_all.deb

# Install Firefox and Java Plugins
run     apt-get install -y firefox icedtea-8-plugin icedtea-netx openjdk-8-jre openjdk-8-jre-headless hsetroot
run	mkdir ~/.vnc

# Reduce java security so Avocents will work
run sed -i 's/^jdk.certpath.*/jdk.certpath.disabledAlgorithms=MD2/g' /etc/java-8-openjdk/security/java.security  
run sed -i 's/^jdk.tls.disabledAlgorithms.*/jdk.tls.disabledAlgorithms=SSLv3/g' /etc/java-8-openjdk/security/java.security
run bash -c 'echo "hsetroot -solid \"#5C066D\"" >> /etc/X11/openbox/autostart'

# Autostart firefox (might not be the best way to do it, but it does the trick)
run     bash -c 'echo "exec openbox-session &" >> ~/.xinitrc'
run	bash -c 'echo "firefox" >> ~/.xinitrc'
run     bash -c 'chmod 755 ~/.xinitrc'
