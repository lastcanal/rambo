RSpec.describe Rambo::RSpec::SpecFile do
  let(:raw_raml)  { Raml::Parser.parse_file(raml_file) }
  let(:raml)      { Rambo::RamlModels::Api.new(raw_raml) }
  let(:spec_file) { Rambo::RSpec::SpecFile.new(raw_raml) }

  before(:each) do
    FileUtils.mkdir_p(File.expand_path("spec/support/examples"))
  end

  after(:each) do
    FileUtils.rm_rf(File.expand_path("spec/support/examples"))
  end

  context "file with examples" do
    let(:raml_file) { File.expand_path("../../../support/foobar.raml", __FILE__) }

    describe "#initialize" do
      it "assigns @raml" do
        expect(spec_file.raml).not_to be_nil
      end

      it "uses the correct schema" do
        expect(spec_file.raml.schema).to eq raw_raml
      end
    end

    describe "#template" do
      it "is a string" do
        expect(spec_file.template.is_a?(String)).to be true
      end
    end

    describe "#render" do
      it "interpolates the correct values" do
        expect(spec_file.render).to include("e-BookMobile API")
      end
    end
  end

  context "file with schema" do
    let(:raml_file) do
      File.expand_path("../../../../features/support/examples/raml/basic_raml_with_schema.raml", __FILE__)
    end

    describe "#initialize" do
      it "assigns @raml" do
        expect(spec_file.raml).not_to be_nil
      end
    end

    describe "#template" do
      it "is a string" do
        expect(spec_file.template.is_a?(String)).to be true
      end
    end
  end
end
