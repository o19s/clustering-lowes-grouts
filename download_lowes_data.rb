require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'rsolr'


@search_url = "http://www.lowes.com/SearchCatalogDisplay?Ntt=mapei+unsanded+grout&storeId=10151&N=0&langId=-1&catalogId=10051&rpp=32&zipCode=22903"
@solr_url = 'http://localhost:8983/solr'



def export_data_from_lowes
  counter = 0;
  
  counter = counter + 1
  doc = Nokogiri::HTML(open(@search_url))
  $stderr.puts "****** Exporting ********"
  
  
  productResults = doc.xpath("//ul[@id='productResults']/li")
  
  parsed_product_data = []
    
  productResults.each do |pr|
    puts pr["id"]
    puts pr.at_xpath(".//h3[@class='productTitle']/a").inner_text
    #puts pr.at_xpath(".//div[@class='pricingArea']")   # We can't get pricing because you have to enter zip code, and don't want to both working around it!
    productInfos = pr.xpath(".//ul[@class='productInfo']/li")
    puts productInfos[0].inner_text.strip
    puts productInfos[1].inner_text.strip
    productBullets = pr.xpath(".//ul[@class='prod-detail']/li")
    productBullets.each do |pb|
      puts pb.inner_text.strip
    end
    
    puts pr.at_xpath(".//img[@class='productImg']")["src"]
    
    productInfos = pr.xpath(".//ul[@class='productInfo']/li")
    
    product = {
      :id => pr["id"],
      :title => pr.at_xpath(".//h3[@class='productTitle']/a").inner_text,
      :item_number => productInfos[0].inner_text.strip,
      :model_number => productInfos[1].inner_text.strip,
      :product_bullets => pr.xpath(".//ul[@class='prod-detail']/li").collect{|pb| pb.inner_text.strip},
      :image => pr.at_xpath(".//img[@class='productImg']")["src"]
    }
    parsed_product_data << product
  end
  
  require 'pp'
  
  pp parsed_product_data
  
  return parsed_product_data
  
  
end

def store_in_solr(parsed_product_data)
  
  # Direct connection
  solr = RSolr.connect :url => @solr_url
  parsed_product_data.each do |data|
    solr_doc = {
      :id => data[:id],
      :title_t => data[:title],
      :item_number_s => data[:item_number],
      :model_number_s => data[:model_number],
      :product_bullets_txt => data[:product_bullets],
      :image_s => data[:image]
    }
    solr.add solr_doc
  end
  solr.commit
  
  
end

#area_code = ARGV[0]
#area_code = 276

parsed_product_data = export_data_from_lowes()
store_in_solr(parsed_product_data)


