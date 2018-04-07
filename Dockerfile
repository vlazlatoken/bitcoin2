FROM ubuntu:trusty
USER root

RUN apt-get update
RUN apt-get install -y python-software-properties
RUN apt-get install -y nano build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils python3 libboost-all-dev software-properties-common

RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get install -y libminiupnpc-dev libzmq3-dev
RUN apt-get install -y libdb4.8-dev libdb4.8++-dev


COPY . /opt
RUN mkdir -p /root/.bitcoin
COPY ./bitcoin.conf /root/.bitcoin/bitcoin.conf
WORKDIR /opt

RUN ./autogen.sh
RUN ./configure
RUN make

EXPOSE 55089 55088

