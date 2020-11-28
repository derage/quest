FROM node

RUN apt-get update \
    && apt-get install -y openssl \
    && rm -rf /var/lib/apt/lists/* \
    && adduser --disabled-login app
USER app

WORKDIR /home/app
# add package.json first so cached layers are saved
ADD --chown=app:app package.json ./

RUN npm install

ADD --chown=app:app . ./

RUN chmod +x ./entrypoint.sh

CMD ["./entrypoint.sh"]
