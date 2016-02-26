require "rails_helper"
require "abn_lookup"

describe AbnLookup do
  subject { described_class.new } 

  context "finds a ABN by organisation name and postcode" do
    it "returns the matching abn for the given organisation" do
      expect(subject.find(:name, name: "Connecting Up", postcode: 5000)).to eq("13903061955")
    end

    it "returns false on no valid results" do
      expect(subject.find(:name, name: "noone is called this", postcode: 1000)).to eq(false)
    end
  end
end
