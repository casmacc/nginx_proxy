# Using SSL

## Installing

Clone this repo onto a server with Ubuntu 18.04, docker and docker-compose.

Then:
    $ sudo apt install certbot
    $ sudo apt install ruby

Set or export the NHOST environment variable...

    $ echo "NHOST=<yourhost>" > env

That should do it...

## Setting up SSL

Make sure you wildcard DNS working.  Then:

    $ ./bin/dockerup
    $ ./bin/ssl_setup

Then test https with a browser...

## Renew 

sudo certbot certonly --webroot --webroot-path=volumes/html --domain h1.bugmark.plus --agree-tos --email andy@r210.com --noninteractive
