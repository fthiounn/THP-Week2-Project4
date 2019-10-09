#But de ce programme :
# recuperer l'ensemble des paires {nom=>value} des crypto presentes sur coinMarketCap
require 'nokogiri'
require 'open-uri'
URL = "https://coinmarketcap.com/all/views/all/"

def perform
	page = open_url(URL)
	list_key = page.xpath("//a[@class='currency-name-container link-secondary']")
	list_value = page.xpath("//a[@class='price']")
	crypto_hash = Hash.new
	crypto_hash = make_hash(list_key,list_value)
end
def open_url(path)
	return Nokogiri::HTML(open(path)) 
end
def make_hash (list_key,list_value)
	tmp_hash = Hash.new
	for a in 0..list_key.size-1 do
		tmp_hash[list_key[a].text]=list_value[a].text
	end
	return tmp_hash
end
perform