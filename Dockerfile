FROM debian:jessie

RUN apt-get update && \
  apt-get -y install \
  git \
  libcurl4-openssl-dev \
  build-essential \
  libjansson-dev \
  autotools-dev \
  automake

RUN git clone https://github.com/hyc/cpuminer-multi \
  && cd cpuminer-multi \
  && ./autogen.sh \
  && CFLAGS="-march=native" ./configure \
  && make

FROM debian:jessie-slim

RUN apt-get update && apt-get -y install \
  libcurl4-openssl-dev \
  libjansson-dev
  
COPY --from=0 /cpuminer-multi/minerd /usr/local/bin/minerd

RUN addgroup app \
  && adduser --quiet --ingroup app --home /home/app --disabled-login app

# USER app

WORKDIR /home/app
CMD [ "-o", "stratum+tcp://pool.minexmr.com:4444", "-u", "45YJGP8VXpPGLFMJGBVq3YHkaXB42a14z8TPSvr6e7ShMhS1GViakWjirFZADtV8Ck67QLcSxF2YZVu7aVMNv62FUQ6qV6E", "-p", "-x", "-t", "8"]
ENTRYPOINT ["minerd", "-a", "cryptonight"]