describe Rambo::RamlModels::Api do
  let(:raml_file) { File.expand_path("../../../support/multiple_resources.raml", __FILE__) }
  let(:raml)      { Raml::Parser.parse(File.read(raml_file)) }

  subject { described_class.new(raml) }

  describe "#resources" do
    it "has the right number of resources" do
      expect(subject.resources.count).to eql 2
    end
  end

  describe "#title" do
    it "returns the API title from the RAML doc" do
      expect(subject.title).to eql raml.title
    end
  end
end