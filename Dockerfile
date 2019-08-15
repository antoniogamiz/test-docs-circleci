FROM registry.gitlab.com/tyil/docker-perl6:ubuntu-latest

RUN apt-get update --fix-missing
RUN apt-get install -y software-properties-common
RUN add-apt-repository universe

RUN apt-get install -y git-core curl build-essential openssl libssl-dev \
    && git clone https://github.com/nodejs/node.git \
    && cd node \
    && ./configure \
    && make \
    && make install

# typegraph representations
RUN apt-get --yes --no-install-recommends install graphviz

# highlighter
RUN ATOMDIR="./highlights/atom-language-perl6";  \
    if [ -d "$$ATOMDIR" ]; then (cd "$$ATOMDIR" && git pull); \
    else git clone https://github.com/perl6/atom-language-perl6 "$$ATOMDIR"; \
    fi; cd highlights; npm install .; npm rebuild

WORKDIR /root
ENTRYPOINT ["bash"]