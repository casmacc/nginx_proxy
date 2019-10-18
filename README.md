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

## Proxy to Service on Docker Host

You can proxy from to a service on the host machine.  The service could be a
process running directly on the host, or on a Virtual Machine that listens to a
port on the host.

    servicex:
      image: qoomon/docker-host
      restart: on-failure
      cap_add: [ 'NET_ADMIN', 'NET_RAW' ]
      expose:
        - "5020"
      environment:
        VIRTUAL_HOST: servicex.casmacc.net
        HTTPS_METHOD: noredirect
