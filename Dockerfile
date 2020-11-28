FROM node

WORKDIR /app
# add package.json first so cached layers are saved
ADD package.json ./

RUN npm install

ADD . /app

RUN apt-get update && \
    apt-get install -y openssl && \
    chmod +x ./entrypoint.sh

CMD ["./entrypoint.sh"]
