# nginx_proxy

Nginx Service Proxy

## Usage

### Docker Run

To run it:

    $ docker run -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro casmacc/nginx_proxy

Then start any containers you want proxied with an env var `VIRTUAL_HOST=subdomain.yourdomain.com`

    $ docker run -e VIRTUAL_HOST=sh1.myhost.com -p 3090:3090 casmacc/sinatra_helloworld
    $ docker run -e VIRTUAL_HOST=sh2.myhost.com -p 3091:3090 casmacc/sinatra_helloworld

To run interactively:

    $ docker run -p 80:80 -it -v /var/run/docker.sock:/tmp/docker.sock:ro casmacc/nginx_proxy bash

or against a running container:

    $ # get list of container names
    $ docker ps 
    # # run bash on container
    $ docker exec -it <container_name> bash

### Docker Compose

See the file `compose_basic` and `compose_ssl` directories for examples...

## Rebuilding the Image

    docker build . -t casmacc/nginx_proxy
    docker push casmacc/nginx_proxy

## Proxy to a VM Guest

You can proxy from the host to a web server running on a local virtual machine.

First, start the VM and expose the web service on a specific port.

Then start a [dummy container][1] and define `VIRTUAL_HOST` and `VIRTUAL_PORT`
for your web service.

    $ docker run -e VIRTUAL_HOST=sh3.myhost.com VIRTUAL_PORT=3095 cwempe/docker-dummy
    $ docker run -e VIRTUAL_HOST=sh4.myhost.com VIRTUAL_PORT=3096 cwempe/docker-dummy

The `VIRTUAL_PORT` is the port that is exposed by your virtual machine.

Note: this will only work when the NGINX proxy and other docker containers run on the host.

To proxy to another IP address, see the [Cwempe](https://github.com/CWempe/nginx-proxy) fork of `nginx-proxy`.

[1]: https://hub.docker.com/r/cwempe/docker-dummy/
