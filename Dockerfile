FROM node:9 as dependencies

WORKDIR /src
COPY truffle/package.json .
RUN npm install

FROM trufflesuite/ganache-cli:latest
RUN npm install -g truffle
RUN apk add --no-cache bash
WORKDIR /src
COPY --from=dependencies /src/node_modules node_modules/
COPY truffle .
