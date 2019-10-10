#But de ce programme :
# Recuperer tout d'abord la liste des url pour les # mairies du val d'oise
# Recuperer sur chacune de ces pages l'adresse mail pour les joindre

require 'nokogiri'
require 'open-uri'
require 'colorize'


URL = "http://annuaire-des-mairies.com/val-d-oise.html"

def perform
	list_url = get_townhall_urls.map {|x|
		URL[0..30] + x.text[1..-1]
	}
	list_hash = []
	for a in 0..list_url.size-1 do 
		list_hash[a]= Hash.new
		list_hash[a]= get_townhall_email(list_url[a])
	end

	puts "We found #{list_hash.length } townhalls and saved their emails "
	return list_hash
end


def get_townhall_email(townhall_url)
	return nil if townhall_url.nil? || townhall_url.empty?
	mail_hash = Hash.new
	city_name = townhall_url[35..-6]
	list_mail = Nokogiri::HTML(open(townhall_url)).xpath("//*[contains(text(), '@')]")
	list_mail.each { |mail|
		mail_hash[city_name]= mail.text
	}
	if mail_hash.empty? then
		puts "Echec ".red+": No mail found for #{city_name}" 
	else
		puts "Succes ".green+"Extraction des emails de la mairie de #{city_name}"
	end
	return mail_hash
end

def get_townhall_urls
		page = Nokogiri::HTML(open(URL)).xpath("//a[@class='lientxt']/@href")
		puts "Annuaire du val d'oise bien récuperé, extraction des url des mairies" if page.any?
	return page
end
perform