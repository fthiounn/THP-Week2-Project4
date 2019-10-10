#But de ce programme :
# recuperer une liste de tous les deputes
# les mettre sous la forme 
#a = [
#  { 
#    "first_name" => "Jean",
#    "last_name" => "Durant",
#    "email" => "jean.durant@assemblée.fr"
#  },
#  { 
#    "first_name" => "Martin",
#    "last_name" => "Dupont",
#    "email" => "martin.dupont@assemblée.fr"
#  },
#  etc
#]

require 'nokogiri'
require 'open-uri'
require 'colorize'

URL = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
URL2 = "http://www2.assemblee-nationale.fr"

def perform
	#1. recuperation de la liste des url des deputes
	assembly_page = openfile(URL)
	list_deputy_url = assembly_page.xpath("//a[starts-with(@href, '/deputes/fiche/')]/@href")
		#formatage des url
	list_deputy_url = list_deputy_url.map { |deputy|
		URL2 + deputy.text
	}
	#2. on recupere pour chaque URL l'adresse mail ET on rentre tout dans la structure de donnée demandée
	deputy_list = []
	list_deputy_url.each_with_index { |url, index|
		deputy_list[index]= Hash.new
		deputy_list[index] = get_deputy_hash(url)
	}
	puts "We found #{deputy_list.size} deputy"
	return deputy_list
end
def get_deputy_hash (url)
	deputy_page = openfile(url)
	deputy_profile = Hash.new
	#traitement du nom
	full_name = deputy_page.xpath("//div[@class='titre-bandeau-bleu clearfix']/h1/text()")
	puts "Error".red + " - @#{url}  cannot extract full_name" if full_name.text.empty?
	deputy_profile["first_name"] = full_name.text.split(" ").at(1)
	deputy_profile["last_name"] = full_name.text.split(" ").at(2)
	#traitement du mail
	mail = deputy_page.xpath("//a[contains(text(), '@')]")
	puts "Error".red + " - @#{url}  cannot extract mail" if mail.text.empty?
	mail = mail.text.split("@").at(0) + "@assemblee-nationale.fr"
	deputy_profile["email"] = mail

	return deputy_profile
end

def openfile(link)
	page = Nokogiri::HTML(open(link))
	if page then
		puts "Succes".green + " - #{link} succesfully extracted"
		return page
	else
		puts "Error".red + " - #{link}  not extracted" 
		return nil
	end
end

perform