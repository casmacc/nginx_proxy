FROM jwilder/nginx-proxy:latest

MAINTAINER Andy Leak <andy@r210.com>

COPY overlays/static.conf /etc/nginx/conf.d/static.conf
COPY overlays/testfile.html /usr/share/nginx/html/testfile.html

