#!/bin/bash
until $(curl -s --output /dev/null --silent --head --fail http://$ELASTICSEARCH_HOST:$ELASTICSEARCH_PORT); do echo "Waiting for Elasticsearch to be online"; sleep 5; done
