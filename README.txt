Using Clustering to Suggest Tags

I have a concrete counter top that is coloured with a thin surface layer of multiple shades of concrete dye all mixed together.  It has a wonderful earthy look to it, but I've discovered that it doest stand up to my wife swinging around heavy pots and pans!  I tried a sanded grout witht the brand name "Mapei" from Lowes Home Improvement, but it didn't really have the effect I wanted, leaving a built up area that wouldn't take the concrete sealer that makes the counter look shiny.   So I went onto Lowes's website and searched for "Mapei Unsanded Grout" (http://www.lowes.com/SearchCatalogDisplay?storeId=10151&langId=-1&catalogId=10051&N=0&newSearch=true&Ntt=mapei+unsanded+grout), and recieved back 30 results:

https://skitch.com/epugh/8yqa2/shop-mapei-unsanded-grout-at-lowes.com-search-results

While on the face of it, 30 results back sounds like a great thing, but then I scrolled down the page and was overwhelmed by all the choices.  It seemed like I had 30 differenct choices to pick from.  Go ahead, click the link and try it yourself!  

I scrolled up and down a couple of times and started realizing that I didn't have 30 choices.  I actually had TWO choices: a "Unsanded Powder Grout" and a "Preimum Unsanded Powder Grout", and they come in a variety of colors and sizes.  So here I am, frantically scrolling up and down trying to build a mental model of all my choices, when I think "ah, facets should help me".  I knew I was doing just a bit of patching, so Iw atned the smallest size possible. And I knew I wanted a rich earthy red/brown color to match the existing concrete counter top.  Unfortunantly neither "Size" nor "Color" are facet options.

So I thought, instead of trying to build a mental model of all thirty results, why don't I leverage clustering to see if I can pull out of the unstructured data some shared clusters that would act as facets?   This blog post is going to walk you through how I did this.

1) Extracting the Data
I wrote a very simple Ruby script that downloads just the 30 results from Lowes.com and puts them into a Solr index.  If you check out the code from 
 
