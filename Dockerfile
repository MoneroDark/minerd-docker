#
# Dockerfile for cpuminer
# usage: docker run creack/cpuminer --url xxxx --user xxxx --pass xxxx
# ex: docker run creack/cpuminer --url stratum+tcp://ltc.pool.com:80 --user creack.worker1 --pass abcdef
#
#

FROM		ubuntu:14.04
MAINTAINER	Guillaume J. Charmes <guillaume@charmes.net>

RUN		apt-get update -qq && apt-get install -qqy automake && apt-get install -qqy libcurl4-openssl-dev && apt-get install -qqy git && apt-get install -qqy make


RUN		git clone https://github.com/MoneroDark/cpuminer-multi
RUN		cd cpuminer && ./autogen.sh
RUN		cd cpuminer && ./configure CFLAGS="-O3"
RUN		cd cpuminer && make

WORKDIR		/cpuminer
ENTRYPOINT	["./minerd"]
