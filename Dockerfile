FROM heroku/nodejs

# Install prerequisites
RUN apt-get update && apt-get install -y \
  curl

RUN npm config set registry https://registry.npmjs.org/
RUN npm install

CMD ["npm", "run", "start:pm2"]
