#!/bin/sh
ganache-cli &
sleep 2
truffle test
cat test-results.xml
