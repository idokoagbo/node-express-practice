FROM node:17-alpine3.12

WORKDIR /usr/src/backend

COPY package*.json ./

RUN npm install

COPY . /usr/src/backend

EXPOSE ${APP_PORT}

CMD [ "npm", "start"]