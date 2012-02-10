#!/bin/sh

pushd

#cd ../../../asf_trunk/solr/example/
cd example

#java -Djetty.port=8983  -Dsolr.solr.home=../../../trunk/recipe/playground/solr -Dsolr.clustering.enabled=true -Xmx2048M -Xms1024M -jar start.jar
java -Djetty.port=8983  -Dsolr.solr.home=../solr -Dsolr.clustering.enabled=true -Xmx2048M -Xms1024M -jar start.jar

popd
