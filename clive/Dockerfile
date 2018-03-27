FROM node:7.4-alpine

RUN mkdir -p /usr/src/clive
RUN mkdir -p /usr/src/clive/node_modules
WORKDIR /usr/src/clive

COPY contracts /usr/src/clive/contracts
COPY migrations /usr/src/clive/migrations
COPY test /usr/src/clive/test
COPY truffle.js /usr/src/clive/truffle.js
COPY cli.bundled.js /usr/local/lib/node_modules/truffle/build/cli.bundled.js

RUN apk add -t .gyp --no-cache git python g++ make \
    && npm install -g truffle \
    && npm install babel-register --save-dev\
    && npm install -E zeppelin-solidity \
    && apk del .gyp

RUN apk add --no-cache bash

EXPOSE 8080
#ENTRYPOINT ["bash"]
#, "-c", "truffle migrate"]
