FROM debian:stretch

MAINTAINER David Stefan <stefda@gmail.com>

ENV OSMIUM_VERSION 2.13.1
ENV OSMIUM_TOOL_VERSION 1.7.1

RUN apt-get update
RUN apt-get update && apt-get install -y \
    wget g++ cmake cmake-curses-gui make libexpat1-dev zlib1g-dev libbz2-dev libsparsehash-dev \
    libboost-program-options-dev libboost-dev libgdal-dev libproj-dev doxygen graphviz pandoc

RUN mkdir /var/install
WORKDIR /var/install

RUN wget https://github.com/osmcode/libosmium/archive/v${OSMIUM_VERSION}.tar.gz && \
    tar xzvf v${OSMIUM_VERSION}.tar.gz && \
    rm v${OSMIUM_VERSION}.tar.gz && \
    mv libosmium-${OSMIUM_VERSION} libosmium

RUN cd libosmium && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF -DINSTALL_PROTOZERO=ON .. && \
    make

RUN wget https://github.com/osmcode/osmium-tool/archive/v${OSMIUM_TOOL_VERSION}.tar.gz && \
    tar xzvf v${OSMIUM_TOOL_VERSION}.tar.gz && \
    rm v${OSMIUM_TOOL_VERSION}.tar.gz && \
    mv osmium-tool-${OSMIUM_TOOL_VERSION} osmium-tool

RUN cd osmium-tool && \
    mkdir build && cd build && \
    cmake -DOSMIUM_INCLUDE_DIR=/var/install/libosmium/include/ .. && \
    make

RUN mv /var/install/osmium-tool/build/src/osmium /usr/bin/osmium
