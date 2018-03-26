FROM node:9 as dependencies

WORKDIR /src
COPY truffle/package.json .
RUN npm install

FROM node:9-alpine
RUN npm install -g truffle
RUN npm install -g ganache-cli
WORKDIR /src
COPY --from=dependencies /src/node_modules node_modules/
COPY truffle .
COPY launch.sh .

CMD ["./launch.sh"]
