require_relative '../lib/trader'

describe "open_url method, it should return the html content of the url" do
  it "TEST empty file" do
    expect(open_url("")).to eq("")
  end
  it "TEST if type = HTML" do
    expect(open_url("google.com")).to start_with?("<!doctype html>")
  end
end
describe "make_hash method, it should return a hash joining the 2 arrays" do
  it "TEST empty hash" do
    expect(make_hash([],[])).to eq({})
  end
  it "TEST hash size" do
    expect(make_hash(["a","b"],[1,2])).to eq({"a"=>"1", "b"=>"2"})
  end
end



