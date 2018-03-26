FROM node:9 as dependencies

WORKDIR /src
COPY truffle/package.json .
RUN npm install

FROM node:9-alpine
RUN npm install -g truffle
RUN npm install -g ganache-cli
RUN npm install -g mocha
RUN npm install -g mocha-junit-reporter
WORKDIR /src
COPY --from=dependencies /src/node_modules node_modules/
COPY truffle .
COPY launch.sh .
COPY truffle/truffle-jenkins.js truffle.js

CMD ["./launch.sh"]
