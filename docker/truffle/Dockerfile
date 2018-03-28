FROM node:9 as dependencies

WORKDIR /src
COPY clive/package.json .
RUN npm install

FROM node:9-alpine
RUN npm install -g truffle
WORKDIR /src
COPY --from=dependencies /src/node_modules node_modules/
COPY clive/ .
