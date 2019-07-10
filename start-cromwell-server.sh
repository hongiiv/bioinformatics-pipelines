#!/bin/bash

cd /opt/cromwell
java -Dconfig.file=google.conf -Dsystem.abort-jobs-on-terminate=true -jar cromwell-43.jar server