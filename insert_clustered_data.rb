require 'rubygems'
require 'rsolr'
require 'net/http'
require 'uri'
require 'json'
require 'pp'

@solr_url = 'http://localhost:8983/solr'
@cluster_urls = %w[http://localhost:8983/solr/clustering?&q=*:*&fq=item_number_s:%22Item+%23%3A+185276%22 http://localhost:8983/solr/clustering?q=*:*]

def add_tags_to_document(doc_id, clusters)  
  response = @solr.get 'select', :params => {:q => "id:#{doc_id}"}
  solr_doc = response["response"]["docs"].first
  solr_doc["tags_smv"] ||= []
  solr_doc["tags_smv"] << clusters
  solr_doc["tags_smv"].flatten!.uniq!
  
  @solr.add solr_doc  
  @solr.commit
end

def get_clusters(cluster_url)
  uri = URI.parse("#{cluster_url}&wt=json")
  response = Net::HTTP.get_response(uri)  
  raise "Response was not 200, response was #{response.code}" if response.code != "200"
  json = JSON.parse(response.body)
  return json["clusters"]
end


@solr = RSolr.connect :url => @solr_url
unless ARGV[0].nil?
  @cluster_urls = [ARGV[0]]
end

@cluster_urls.each do |cluster_url|
  puts "Cluster URL: #{cluster_url}"
  cluster_json = get_clusters(cluster_url)
  cluster_json.each do |cluster|
    puts cluster["labels"]
    cluster["docs"].each do |doc_id|
      add_tags_to_document(doc_id, cluster["labels"])
    end
  end
end



