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
      let!(:network) { CNetworkTwitter.new(:test, context) }

      describe "expect inherit attributes from network" do
        it { expect(network.available_attributes).to include(:title, :description, :share_url) }
      end

      describe "#domain" do
        it { expect(network.available_attributes).to include(:domain) }
      end

      describe "#site" do
        it { expect(network.available_attributes).to include(:site) }
      end

      describe "#creator" do
        it { expect(network.available_attributes).to include(:creator) }
      end

      describe "#card" do
        it { expect(network.available_attributes).to include(:card) }
      end

      describe "pass url params for context" do
        pending
      end
    end
  end
end
