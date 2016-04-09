require 'spec_helper'

describe Rambo::RSpec::SpecFile do
  let(:raml) { Raml::Parser.parse(File.read(raml_file)) }
  let(:spec_file) { Rambo::RSpec::SpecFile.new(raml: raml) }

  context 'file with examples' do
    let(:raml_file) { File.expand_path('../../../support/foobar.raml', __FILE__) }

    describe '#initialize' do
      it 'assigns @raml' do
        expect(spec_file.raml).to eql raml
      end
    end

    describe '#template' do
      it 'is a string' do
        expect(spec_file.template.is_a?(String)).to be true
      end
    end

    describe '#render' do
      it 'interpolates the correct values' do
        expect(spec_file.render).to include('e-BookMobile API')
      end
    end
  end

  context 'file with schema' do
    let(:raml_file) do
      File.expand_path('features/support/examples/basic_raml_with_schema.raml')
    end

    describe '#initialize' do
      it 'assigns @raml' do
        expect(spec_file.raml).to eql raml
      end
    end

    describe '#template' do
      it 'is a string' do
        expect(spec_file.template.is_a?(String)).to be true
      end
    end

    describe '#render' do
      it 'interpolates the correct values' do
        schema = JsonTestData.generate!(raml.resources.first.methods.first.responses.first.bodies.first.schema)
        puts schema
      end
    end
  end
end
