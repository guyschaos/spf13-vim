FROM ubuntu:14.04.1
# docker build --no-cache -t guyschaos/docker-spf13-vim .
RUN apt-get update -qq && apt-get install -y \
git \
vim-nox \
gawk \
graphviz \
id-utils \
exuberant-ctags \
cscope \
wget \
ca-certificates curl gcc libc6-dev make \
bzr git mercurial \
cmake python-dev build-essential \
--no-install-recommends

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN git clone --depth=1  https://github.com/Valloric/YouCompleteMe.git /root/YouCompleteMe
RUN cd /root/YouCompleteMe; git submodule update --init --recursive; ./install.sh --clang-completer

ENV GOLANG_VERSION 1.4.1

RUN curl -sSL https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz \
		| tar -v -C /usr/src -xz

RUN cd /usr/src/go/src && ./make.bash --no-clean 2>&1

ENV PATH /usr/src/go/bin:$PATH

RUN mkdir -p /go/src
ENV GOPATH /go
ENV PATH /go/bin:$PATH
WORKDIR /go


WORKDIR /root
RUN git clone https://github.com/guyschaos/spf13-vim.git
WORKDIR /root/spf13-vim

RUN sh bootstrap.sh

