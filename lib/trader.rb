#But de ce programme :
# recuperer l'ensemble des paires {nom=>value} des crypto presentes sur coinMarketCap
require 'nokogiri'
require 'open-uri'
require 'colorize'
URL = "https://coinmarketcap.com/all/views/all/"

def perform

	page = open_url(URL)
	puts "Error".red + " - HTML not extracted" if !page
	puts "Succes".green + " - Html succesfully extracted" if page

	list_key = page.xpath("//a[@class='currency-name-container link-secondary']")
	puts "Succes".green + " - Coin List succesfully extracted" if list_key.any?
	puts "Error".red + " - Coin List not extracted" if !list_key.any?
	
	list_value = page.xpath("//a[@class='price']")
	puts "Succes".green + " - Price List succesfully extracted" if list_value.any?
	puts "Error".red + " - Price List not extracted" if !list_value.any?
	
	crypto_hash = Hash.new
	crypto_hash = make_hash(list_key,list_value)

	return
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