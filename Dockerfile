FROM node

WORKDIR /app
# add package.json first so cached layers are saved
ADD package.json ./

RUN npm install

ADD . /app

CMD ["npm","start"]
