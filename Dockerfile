FROM ubuntu:16.04

MAINTAINER Isaac A., <isaac@isaacs.site>

RUN apt update \
    && apt upgrade -y \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb http://download.mono-project.com/repo/ubuntu stable-xenial main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt-get update \
    && apt install -y lib32gcc1 lib32stdc++6 unzip curl iproute2 libgdiplus mono-complete \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt install -y nodejs \
    && mkdir /node_modules \
    && npm install --prefix / ws \
    && useradd -d /home/container -m container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
COPY ./wrapper.js /wrapper.js

CMD ["/bin/bash", "/entrypoint.sh"]
