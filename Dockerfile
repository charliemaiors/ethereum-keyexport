FROM ethereum/client-go

ADD start.sh /root/start.sh
ADD . /root/keyExporter

RUN apt-get update && apt-get install -y curl && curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs build-essential python && chmod +x /root/start.sh
RUN cd /root/keyExporter && npm install
ENV PORT 8080
EXPOSE 8080

CMD [/root/start.sh, $@]
