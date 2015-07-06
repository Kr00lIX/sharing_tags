RSpec.shared_examples "a config context attribute" do

  it "expect change title attribute" do
    expect { context.send(network_name) { title "new title" } }.to change { share_context.send(network_name).title }.to("new title")
  end

  it "expect change title attribute" do
    expect(context[network_name]).to receive(:instance_exec)
    context.send(network_name) { title "new title" }
  end

end