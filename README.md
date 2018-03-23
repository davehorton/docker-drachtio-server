# docker-drachtio-server

A [drachtio-server](https://github.com/davehorton/drachtio-server) image (164 MB).

This image includes options to set one or more sip ports for the sip stack to listen to, and it is mandatory to set at least one sip port (by using the `--contact` parameter).

To accept sip traffic on the default port 5060 tcp and udp, for example:
```bash
$ docker run -d --rm --name drachtio --net=host \
    drachtio/drachtio-server drachtio --contact "sip:*;transport=tcp,udp" 
```
The host networking driver only works on Linux hosts. Use the following command for Mac or Windows.
```bash
$ docker run -d --rm --name drachtio -p 5060:5060 -p 9022:9022 \
    drachtio/drachtio-server drachtio --contact "sip:*;transport=tcp,udp"
```

To jump in to a running container with a bash shell:
```bash
$ docker exec -ti drachtio /bin/bash
```

This image supports the following run-time command line parameters
* `--contact` specifies a sip port and associated transport protocol.  Note that multiple --contact params may be used to cause the container to listen on multiple ports. (Note: the value must be a quoted string in the form "[sip|sips]:*:<port>;transport=[tcp|udp|ws]")
* `--port` the tcp port to listen on for application connections (default: 9022)
* `--secret` the shared secret to use to challenge application connections (default: cymru)
* `--loglevel` the loglevel setting (default: info, loglevel may be any of: error, warning, info, and debug)
* `--sofia-loglevel` the log level for the internal sofia sip stack (default: 3, may be 0-9 where 9 is most verbose)



This image exposes the drachtio log directory (/var/log/drachtio)

An example of starting a container with advanced options:
```bash
$ docker run -d --rm --name drachtio --net=host -v /tmp/log:/var/log/drachtio  drachtio/drachtio-server \
     drachtio --contact "sip:*:5080;transport=tcp" --contact "sip:*:5081;transport=tcp"
```
