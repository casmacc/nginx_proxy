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

### Docker Compose

See the file `compose/docker-compose.yml` for details...

To run it:

    $ docker-compose up
    
