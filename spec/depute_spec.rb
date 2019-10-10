require_relative '../lib/depute'

describe "get_deputy_hash method, it takes an url and gives back a hash with the deputy profile" do
  it "test wrong url" do
    expect(get_deputy_hash("")).to eq(nil)
  end
  it "test random url" do
    expect(get_deputy_hash("https://www.google.com/")).to eq(nil)
  end
  it "test good url" do
    expect(get_deputy_hash("http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA722038")).to eq({"first_name"=>"Damien","last_name"=>"Adam","email"=>"damien.adam@assemblee-nationale.fr"})
  end
end


describe "open_url method, takes a url, return the html" do
  it "TEST empty url" do
    expect(open_url("")).to eq(nil)
  end
  it "TEST good url" do
    expect(open_url("https://www.google.com/")).to be_kind_of(Nokogiri::HTML::Document)
  end
end



