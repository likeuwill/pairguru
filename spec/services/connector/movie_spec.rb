require "rails_helper"

describe Connector::Movie do
  subject { described_class.new("Pulp Fiction") }

  context "remote api response is valid", mock_response: true do
    it "responds with cover url" do
      expect(subject.cover).to eq "#{described_class::API_DOMAIN}//pulp_fiction.jpg"
    end

    it "responds with rating" do
      expect(subject.rating).to eq 8.9
    end

    it "responds with plot" do
      expect(subject.plot).to eq "The lives of two mob hit men, a boxer..."
    end
  end

  context "remote api response is invalid", mock_invalid_response: true do
    it "responds with empty cover if response is invalid" do
      expect(subject.cover).to eq nil
    end

    it "responds with empty rating if response is invalid" do
      expect(subject.rating).to eq nil
    end

    it "responds with empty plot if response is invalid" do
      expect(subject.plot).to eq nil
    end
  end
end
