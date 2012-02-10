#!/bin/sh

cd example
java -Djetty.port=8983  -Dsolr.solr.home=../solr -Dsolr.clustering.enabled=true -Xmx2048M -Xms1024M -jar start.jar
