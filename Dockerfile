FROM ethereum/client-go

RUN apt-get update && apt-get install -y curl && curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs build-essential python supervisor dos2unix && locale-gen en_US.UTF-8
ADD . /root/keyExporter
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ENV LANG en_US.UTF-8
RUN cd /root/keyExporter && npm install && dos2unix genesis.template

RUN echo "ciao" > password.txt 
RUN export ACCOUNT=$(/geth --password password.txt account new | awk '{print $2}' | tr -d '{' | tr -d '}') && python /root/keyExporter/replace.py

RUN /geth --networkid "3821" init /root/keyExporter/genesis.json

EXPOSE 3000

ENTRYPOINT supervisord
