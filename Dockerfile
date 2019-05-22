FROM heroku/nodejs

# Install prerequisites
RUN apt-get update && apt-get install -y \
  curl

RUN npm install

CMD node app.js
