#!/bin/sh
ganache-cli &
sleep 2
truffle test
sleep 2
