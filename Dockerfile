FROM ethereum/client-go

ADD . /root/keyExporter
RUN apt-get update && apt-get install -y curl && curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs build-essential python supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN cd /root/keyExporter && npm install

RUN echo "ciao" > password.txt 
RUN export ACCOUNT = "$(geth --password password.txt new account)"

RUN sed -i "s/  \"coinbase\"   : \"\[DefaultAccount\]\",/  \"coinbase\"   : \"$ACCOUNT\",/g" /root/keyExporter/genesis.json 
RUN sed -i "s/\"\[DefaultAccount\]\": {\"balance\": \"1606938044258990275541962092341162602522202993782792835301376\"}/\"$ACCOUNT\": {\"balance\": \"1606938044258990275541962092341162602522202993782792835301376\"}/g" /root/keyExporter/genesis.json

RUN geth --networkid "1900" init /root/keyExporter/genesis.json 

EXPOSE 3000

ENTRYPOINT supervisord