FROM ubuntu:14.04

RUN sudo apt-get update && sudo apt-get install -qy curl
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -

RUN sudo apt-get --purge remove node

RUN sudo apt-get -y install nodejs

RUN sudo npm install -g how2

EXPOSE 80

CMD tail -f /dev/null
