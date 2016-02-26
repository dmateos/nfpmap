require "rails_helper"
require "abn_lookup"

describe AbnLookup do
  context "name lookup" do
    subject { described_class.new(:name, name: "Connecting Up", postcode: 5000 )  } 

    it "looks up an organisation based on name" do
      expect(subject.find_by_name("")).to eq(nil)
    end
  end

  context "abn lookup" do
    subject { described_class.new(:abn, abn: "13903061955" )  } 

    it "looks up an organisation based on abn" do
      expect(subject.find_by_abn("")).to eq(nil)
    end
  end
end
