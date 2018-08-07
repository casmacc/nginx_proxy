# Using SSL

## Installing

Clone this repo onto a server with Ubuntu 18.04, docker and docker-compose.

Then:
    $ sudo apt install certbot
    $ sudo apt install ruby

Set or export system environment variables...

    $ echo "BASE_HOSTNAME=<yourhost>" > .env
    $ echo "LE_EMAIL=<yourmail>"      > .env

That should do it...

## Setting up SSL

Make sure wildcard DNS working with your DNS registrar.  Then:

    $ ./bin/dockerup     # start docker
    $ ./bin/ssl_list     # list domains
    $ ./bin/ssl_test     # test to see if the LetsEncrypt HTTP-auth process works
    $ ./bin/ssl_dry_run  # test LetsEncrypt w/o generating certs
    $ ./bin/ssl_gen      # generate LetsEncrypt certs
    $ ./bin/ssl_copy     # copy certs to a working directory

After the `ssl_copy` step, kill dockerup then restart.

Then test https with a browser...

## Making an Index Page

This is optional...

    $ ./bin/ssl_index > volumes/html/index.html

Then in your browser, visit `<yourhost>`.

## Renew 

Every week, run:

    $ ./bin/ssl_renew
    $ ./bin/ssl_copy
    $ docker-compose restart

Cron Process TBD...
