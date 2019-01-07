# Using SSL

## Installing

Clone this repo onto a host with Ubuntu 18.04, docker and docker-compose.
Note: **do not** run an instance of nginx on the host.

Then:

    $ sudo apt install certbot
    $ sudo apt install ruby

Set or export system environment variables...

    $ echo "BASE_HOSTNAME=<yourhost>" > env
    $ echo "LE_EMAIL=<yourmail>" >> env

Then start the system with `bin/dockerup`.

## Setting up SSL

    NOTE for this to work your machine needs to be on the 
    public internet!  It won't work behind the firewall! 

Make sure wildcard DNS working with your DNS registrar.  Then:

    $ bin/dockerup     # start docker
    $ bin/ssl_list     # list domains
    $ bin/ssl_test     # test for valid LetsEncrypt HTTP-auth process 
    $ bin/ssl_dry_run  # test LetsEncrypt w/o generating certs
    $ bin/ssl_gen      # generate LetsEncrypt certs
    $ bin/ssl_copy     # copy certs to a working directory

After the `ssl_copy` step, restart using `docker-compose restart`.

Then test https with a browser...

## Renew 

Every week, run:

    $ ./bin/ssl_renew
    $ ./bin/ssl_copy
    $ docker-compose restart

## Notes

We don't use wildcard certs because they require DNS changes, which are unique
and specific to each registrar.  Too much overhead.

Let's Encrypt authenticates by looking up a file in the
`/.well-known/acme-challenge` subdirectory of each subdomain.

The `nginx-proxy` routes all requests for the `/.well-known` path to the base domain.

In `volumes/vhost.d/default_location`:

    location /.well-known {
      proxy_pass http://myhost.com;
    }

To view the test-auth files:

    curl http://myhost.com/.well-known/acme-challenge/test_myhost_com.html
    curl http://s1.myhost.com/.well-known/acme-challenge/test_s1_myhost_com.html

If you get a `503`, check `vhost.d/default_location`.

Cheatsheet:

- `docker ps` to get a list of containers (`alias dkps`)
- `docker exec -it <container> bash` to start a bash shell (`alias dkb`)
- `nginx -s reload` restarts nginx 

## DNS for Development

When using `/etc/hosts`: add an entry for the host domain and every subdomain.

When using `dnsmasq`: add these lines to your config:

    address=/myhost.com/192.168.1.77
    address=/.myhost.com/192.168.1.77

(note use your valid IP address!)

## TBD

Cron Process...
