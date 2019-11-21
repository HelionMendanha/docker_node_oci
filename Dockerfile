FROM ubuntu:19.04

LABEL maintainer="helion@mendanha.com.br"

ADD files/instantclient-basic-linux.x64-19.3.0.0.0dbru.zip /opt

RUN apt-get update \
#	&& echo "America/Sao_Paulo" | tee /etc/timezone \
	&& apt-get install -y zip ca-certificates curl dirmngr apt-transport-https lsb-release \
	&& curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - \
#	&& apt-get install -y --no-install-recommends ca-certificates nodejs npm tzdata \
	&& mkdir -p /opt/oracle \
	&& unzip /opt/instantclient-basic-linux.x64-19.3.0.0.0dbru.zip -d /opt/oracle \
	&& sh -c "echo /opt/oracle/instantclient_19_3 > /etc/ld.so.conf.d/oracle-instantclient.conf" \
	&& rm -rf /opt/*.zip \
	&& ldconfig \
	&& apt-get install -y nodejs npm \
	&& node --version \
	&& npm --version \
	&& date

WORKDIR /app/bundle

EXPOSE 3000

CMD ["node"]


# nohup docker build -t helionmendanha/node:12.10.0 . &
# docker run --rm -it -v /root/app_oni_api:/app/bundle -p 3001:3000 -w /app/bundle helionmendanha/node:12.10.0 bash
