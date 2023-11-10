FROM alpine:3.17

RUN apk update && apk add --no-cache nginx openssl

COPY ./conf/nginx.conf /etc/nginx/
COPY ./tools/ssl-script.sh /

RUN chmod +x /ssl-script.sh
RUN ./ssl-script.sh
RUN rm /ssl-script.sh

ENTRYPOINT ["nginx", "-g", "daemon off;"]
