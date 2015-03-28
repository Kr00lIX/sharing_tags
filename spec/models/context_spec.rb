describe SharingTags::Context do

  before do
    SharingTags.configure do
      twitter do
        title         "Twitter title"
      end

      facebook do
        title        "Facebook title"
      end
    end
  end

  let(:config) { SharingTags.config }

  describe "method missing" do
    let(:context) { SharingTags::Context.new(:foo, config) }

    it "expect save network attributes to default network" do
      expect { context.title "some title" }.to change { context.default_network.attributes[:title] }
    end

    it "expect raise error when try define unavailable network attribute" do
      expect { context.summary = "title" }.to raise_error(SharingTags::Network::Error)
    end
  end
end