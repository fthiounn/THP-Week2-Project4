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

	return crypto_hash
end
def open_url(link)
	return nil if (link.empty? || link.nil?)
	page = Nokogiri::HTML(open(link))
	if page then
		puts "Succes".green + " - #{link} succesfully extracted"
		return page
	else
		puts "Error".red + " - #{link}  not extracted" 
		return nil
	end
end
def make_hash (list_key,list_value)
	return nil if (!list_key.kind_of?(Array) || !list_value.kind_of?(Array))
	tmp_hash = Hash.new
	for a in 0..list_key.size-1 do
		tmp_hash[list_key[a].text]=list_value[a].text
	end
	return tmp_hash
end
perform