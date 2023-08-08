require "rails_helper"

RSpec.describe ApiKey do
  it "makes api keys" do
    api_key = ApiKey.generator

    expect(api_key).to be_a(String)
    expect(api_key.length).to eq(24)
  end
end