FROM gcc

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get install -y libsodium-dev \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ADD . /src/
WORKDIR /src/

RUN \
  ./autogen.sh && \
  ./configure && \
  make && \
  make install

ENTRYPOINT [ "dnscrypt-proxy", "--local-address", "0.0.0.0" ]
