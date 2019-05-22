FROM node:12.2.0-alpine

# Install prerequisites
RUN apk update && apk upgrade && \
  apk add --no-cache bash git openssh

RUN apk add --no-cache --virtual .gyp \
  vim \
  curl

RUN npm config set registry https://registry.npmjs.org/
RUN npm install
RUN npm install pm2 -g

RUN apk del .gyp

CMD ["npm", "start"]
