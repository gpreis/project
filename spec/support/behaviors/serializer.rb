shared_examples 'serializer' do
  let(:serializer)   { described_class.new resource }
  let(:serializered) { ActiveModelSerializers::Adapter.create serializer }

  subject { JSON.parse serializered.to_json }

  it 'follows the json:api' do
    expect(subject.dig('data', 'id')).to eq(resource.id.to_s)
    expect(subject.dig('data', 'type')).to eq(resource.model_name.plural)
    expect(subject.dig('data', 'attributes')).to be_present
  end

  it 'has the documented attributes' do
    attrs = subject.dig('data', 'attributes').keys

    expect(attrs).to contain_exactly(*attributes_keys)
  end
end
