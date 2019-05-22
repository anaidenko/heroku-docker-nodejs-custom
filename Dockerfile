# Create image based on the official Node 12 image from the dockerhub
FROM node:12.2.0-alpine

ENV PORT=8080

RUN apk update && apk upgrade && \
  apk add --no-cache bash git openssh

RUN apk add --no-cache --virtual .gyp \
  vim \
  curl

# Create a directory where our app will be placed
RUN mkdir -p /usr/src/app

# Change directory so that our commands run inside this new directory
WORKDIR /usr/src/app

# Copy dependency definitions
COPY package*.json /usr/src/app/

# Install dependecies
RUN npm config set registry https://registry.npmjs.org/
RUN npm install

# Get all the code needed to run the app
COPY . .

RUN npm install

RUN apk del .gyp

# Create a user group 'safely'
RUN addgroup -S safely

# Create a user 'safely-app' under 'safely'
RUN adduser -S -D -h /usr/src/app safely-app safely

# Chown all the files to the app user.
RUN chown -R safely-app:safely /usr/src/app

# Switch to 'safely-app' user
USER safely-app

# Expose the port the app runs in (4200 by default)
EXPOSE $PORT

# Serve the app
CMD [ "npm", "start" ]
