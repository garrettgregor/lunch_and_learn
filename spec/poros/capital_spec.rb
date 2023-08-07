require "rails_helper"

RSpec.describe Capital do
  it "makes capital objects" do
    attributes = { capital: ["Abuja"] }
    capital = Capital.new(attributes)

    expect(capital).to be_a(Capital)
    expect(capital.name).to eq("Abuja")
  end
end
