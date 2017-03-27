require File.expand_path '../spec_helper.rb', __FILE__

describe "Sinatra app" do

  it "get the home page" do
    get '/'
    expect(last_response.body).to match(/Todo/)
  end
end
