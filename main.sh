#!/bin/bash

OUTPUT="analysis-$(date +%s)"
SOURCES=$OUTPUT/sources
NEO4J=$OUTPUT/neo4j
mkdir -p $SOURCES $NEO4J

tee >(./channels.sh > ${SOURCES}/channels.csv) \
    >(./nodes.sh > ${SOURCES}/nodes.csv) \
    | cat > ${SOURCES}/graph.json
cp schema.cypher data.cypher ${SOURCES}/

docker run \
  --volume=$(pwd)/${NEO4J}:/data \
  --volume=$(pwd)/${SOURCES}:/var/lib/neo4j/import \
  neo4j:latest bin/neo4j-admin import --nodes import/nodes.csv --relationships import/channels.csv

docker run -p 7474:7474 -p 7687:7687 \
  --volume=$(pwd)/${NEO4J}:/data \
  --volume=$(pwd)/${SOURCES}:/var/lib/neo4j/import \
  --env NEO4JLABS_PLUGINS='["apoc", "graph-data-science"]' \
  --env NEO4J_AUTH=none \
  --env apoc.import.file.enabled=true \
  --env apoc.initializer.neo4j.0='CALL apoc.cypher.runSchemaFile("file://import/schema.cypher")' \
  --env apoc.initializer.neo4j.1='CALL apoc.cypher.runFile("file://import/data.cypher")' \
  neo4j:latest
