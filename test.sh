#!/bin/bash
set -e
expected="200"
actual=`wget --server-response http://localhost:8080/engine/v1/status 2>&1 | awk '/^  HTTP/{print $2}'`
echo "Expecting: $expected"
echo "Server says: $actual"
if [ "$expected != "$actual ]; then
    echo "Test failed"
    exit 1
else
    echo "Test passed"
    exit 0
fi