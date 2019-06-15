FROM ubuntu:bionic AS ubuntu
WORKDIR /app

RUN apt-get update
RUN apt-get install -y build-essential python
RUN apt-get install -y nodejs npm

COPY . ./
RUN npm install
RUN npm run build
RUN rm -rf node_modules/
RUN npm install --production

FROM node:10.15.3-alpine
WORKDIR /app

COPY package.json ormconfig.js tsconfig-paths-bootstrap.js .env ./
COPY --from=ubuntu /app/node_modules ./node_modules
COPY --from=ubuntu /app/dist ./dist

CMD node -r ./tsconfig-paths-bootstrap.js ./dist/server.js
EXPOSE 3000
