FROM ubuntu:18.04
RUN apt update
RUN apt install -y git
RUN apt install -y curl
RUN apt -y install nodejs

RUN node -v
RUN apt install -y npm

RUN npm install -y -g newman@3 --unsafe-perm

# FROM openjdk:jre-slim
# ADD https://github.com/mihinduranasinghe/WSO2-APIMCLI/ /usr/local/bin/apimcli

COPY apimcli /usr/local/bin/apimcli
RUN chmod +x /usr/local/bin/apimcli

WORKDIR /usr/src/app
COPY . /usr/src/app
# COPY . .
RUN chmod +x /usr/src/app/script.sh
RUN cd $GITHUB_WORKSPACE

ENTRYPOINT ["/usr/src/app/script.sh"]