FROM node:9 as dependencies

WORKDIR /src
COPY truffle/package.json .
RUN npm install \
    && npm install mocha --save-dev \
    && npm install mocha-junit-reporter --save-dev

FROM node:9-alpine
RUN npm install -g truffle \
    && npm install -g ganache-cli
RUN apk add --no-cache bash
WORKDIR /src
COPY --from=dependencies /src/node_modules node_modules/
COPY truffle .
COPY launch-ganache.sh .
COPY truffle/truffle-jenkins.js truffle.js

CMD ["./launch-ganache.sh"]
ENTRYPOINT ["truffle"]
