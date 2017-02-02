FROM ethereum/client-go

ADD . /root/keyExporter
RUN apt-get update && apt-get install -y curl && curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs build-essential python supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN cd /root/keyExporter && npm install

EXPOSE 3000

ENTRYPOINT supervisord