FROM heroku/nodejs

# Install prerequisites
RUN apt-get update && apt-get install -y \
  curl

CMD ['node', 'app.js']
