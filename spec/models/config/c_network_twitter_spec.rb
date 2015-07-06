module SharingTags
  class Config
    describe SharingTags::Config::CNetworkTwitter do
      before do
        SharingTags.configure do
          twitter do
            title         "Title"
          end
        end
      end

      let!(:config)  { Config.new }
      let!(:context) { CContext.new(:test, config) }
      let!(:c_network) { CNetworkTwitter.new(network_name, context) }
      let(:network_name) { :twitter }
      let(:network) { context.share_context[network_name] }

      describe "expect inherit attributes from network" do
        it { expect(c_network.available_attributes).to include(:title, :description, :share_url) }
      end

      describe "#domain" do
        let(:network_attr) { :domain }
        it_behaves_like "a config network attribute"
      end

      describe "#site" do
        let(:network_attr) { :site }
        it_behaves_like "a config network attribute"
      end

      describe "#creator" do
        let(:network_attr) { :creator }
        it_behaves_like "a config network attribute"
      end

      describe "#card" do
        let(:network_attr) { :card }
        it_behaves_like "a config network attribute"
      end

      describe "pass url params for context" do
        pending
      end
    end
  end
end
