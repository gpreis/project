require 'rails_helper'

describe TransmissionSerializer do
  let(:resource)        { create :transmission }
  let(:attributes_keys) { %w[name description status] }

  it_behaves_like 'serializer'
end
