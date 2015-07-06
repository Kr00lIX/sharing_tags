RSpec.shared_examples "a config network attribute" do
  let(:network_attr_val) { "# #{network_attr} #" }

  it { expect(c_network.available_attributes).to include(network_attr) }
  it { expect(c_network).to respond_to(network_attr) }

  it "expect set attribute as constant value" do
    expect do
      c_network.send(network_attr, network_attr_val)
    end.to change { network.send(network_attr) }.from(nil).to(network_attr_val)
  end

  it "expect set attribute for proc value" do
    expect do
      c_network.send(network_attr) { network_attr_val }
    end.to change { network.send(network_attr) }.from(nil).to(network_attr_val)
  end

  it "expect save attribute to network attributes" do
    expect(network).to receive(:assign).with(network_attr, network_attr_val)
    c_network.send(network_attr, network_attr_val)
  end
end