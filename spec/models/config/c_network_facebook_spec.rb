module SharingTags
  class Config
    describe SharingTags::Config::CNetworkFacebook do
      before do
        SharingTags.configure do
          facebook do
            title         "Title"
          end
        end
      end

      let!(:config)  { Config.new }
      let!(:context) { CContext.new(:test, config) }
      let!(:network) { CNetworkFacebook.new(:test, context) }

      describe "expect inherit attributes from network" do
        it { expect(network.available_attributes).to include(:title, :description, :share_url) }
      end

      describe "#app_id" do
        it { expect(network.available_attributes).to include(:app_id) }
      end

      describe "#caption" do
        it { expect(network.available_attributes).to include(:caption) }
      end

      describe "#provider" do
        it { expect(network.available_attributes).to include(:provider) }
      end

      describe "#return_url" do
        it { expect(network.available_attributes).to include(:return_url) }
      end

      describe "pass url params for context" do
        pending
      end
    end
  end
end
