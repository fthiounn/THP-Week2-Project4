#But de ce programme :
# Recuperer tout d'abord la liste des url pour les # mairies du val d'oise
# Recuperer sur chacune de ces pages l'adresse mail pour les joindre

require 'nokogiri'
require 'open-uri'
URL = "http://annuaire-des-mairies.com/val-d-oise.html"

def perform
	get_townhall_urls
end
def get_townhall_email(townhall_url)
	return
end
def get_townhall_urls
	puts URL
	page = open_url(URL)
	puts page
	return open_url(URL).xpath("//a[@class='lientxt']/@href")
end
perform
