#!/bin/bash

set -x
set -m
set -e

/entrypoint.sh couchbase-server &

sleep 15

# Setup index and memory quota
curl -v -X POST http://127.0.0.1:8091/pools/default -d memoryQuota=300 -d indexMemoryQuota=300

# Setup services
curl -v http://127.0.0.1:8091/node/controller/setupServices -d services=kv%2Cn1ql%2Cindex

# Setup credentials
curl -v http://127.0.0.1:8091/settings/web -d port=8091 -d username=Administrator -d password=password

# Setup Memory Optimized Indexes
curl -i -u Administrator:password -X POST http://127.0.0.1:8091/settings/indexes -d 'storageMode=memory_optimized'

curl -X POST -u Administrator:password \
  -d 'name=default' -d 'ramQuotaMB=100' -d 'authType=none' \
  -d 'proxyPort=11221' \
  http://127.0.0.1:8091/pools/default/buckets

# Load travel-sample bucket
# curl -v -u Administrator:password -X POST http://127.0.0.1:8091/sampleBuckets/install -d '["travel-sample"]'

# couchbase-cli bucket-create -c 127.0.0.1:8091 \
#        --bucket=default \
#        --bucket-type=couchbase \
#        --bucket-port=11211 \
#        --bucket-ramsize=100 \
#        --bucket-replica=1 \
#        --bucket-priority=low \
#        --wait \
#        -u Administrator -p password

tail -f /opt/couchbase/var/lib/couchbase/logs/couchdb.log
