FROM ethereum/client-go

RUN apt-get update && apt-get install -y curl && curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs build-essential
ADD . /root/keyExporter
RUN cd /root/keyExporter && npm install && nodejs bin/www &

EXPOSE 3000
