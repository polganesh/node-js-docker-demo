# This image includes node js and npm.
FROM node:12.22.9-alpine3.15
# create node_modules sub directory in /home/node/app
#  change ownershipt to node user
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
# set work dir
WORKDIR /home/node/app
# copy package*.json. it will copy both package and package-lock
COPY package*.json ./
# ensure that all application files are owned by the non root [node] user
#including content of node_modules dir ,switch the user to node
USER node
# install dependencies
RUN npm install
# copy application code with the appropriate permission to app dir on container
COPY --chown=node:node . .
# expose port 8080 on the container and start application.
EXPOSE 8080
CMD [ "node", "app.js" ]
