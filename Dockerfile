FROM jwilder/nginx-proxy:latest

RUN apt-get update
RUN apt-get install vim -yyq

MAINTAINER Andy Leak <andy@r210.com>

