docker-firefox-java
==============

Firefox over Docker via VNC including the necessary Java plugins to support working with a bunch of old Java/Web based management interfaces, such as old Dell DRAC, or Brocade FC switches. This is the product of not being able to access old Dell 1950 servers using current browsers. This Docker image provides an easy way to spin up a browser with full support.

This Dockerfile is based on the work found here: https://github.com/creack/docker-firefox

# [Prepare WSL2 (if required)](https://github.com/microsoft/WSL/issues/4694#issuecomment-556095344)
Prepare wsl2 by creating the file `%userprofile%\.wslconfig` on the host-machine if it doesn't already exist and add the following content:

```
[wsl2]
kernelCommandLine = vsyscall=emulate
```

# How to use

1. Clone the repo:

    ```
    git clone https://github.com/high3eam/docker-firefox-java.git
    cd docker-firefox-java
    ```

2.  Build the docker image


    `docker build -t="dockfire" .`


3.  Start the container


    `docker run -p 5900:5900 dockfire x11vnc -forever -create`


4.  Connect to Firefox using your VNC client of choice on port 5900 


You may wish to add a -v `<localpath>:<containerpath>` if you want to use Virtual Media or the like to mount ISOs for loading Operating Systems/etc. on servers.


Or you can use docker-compose:

1. Build and start

    `docker-compose up -d`

2. Connect to `localhost::5900` with tightVNC Viewer for example


A volume will be mounted `/data/iso:/data` where you can put any files you might need in the container
