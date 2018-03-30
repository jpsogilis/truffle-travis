FROM node:9-alpine
ENV PS1 "\e[2;36m# \e[3;32mClive (mounted) \e[3;34m[\d - \t]\e[1;31m $\e[m "
WORKDIR /clive
RUN apk update && \
    apk upgrade && \
    apk add git bash \
    && npm install -g truffle 
COPY docker/res/cli.bundled.js /usr/local/lib/node_modules/truffle/build/cli.bundled.js
