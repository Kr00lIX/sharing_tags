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
      let!(:c_network) { CNetworkFacebook.new(network_name, context) }
      let(:network_name) { :facebook }
      let(:network) { context.share_context[network_name] }

      describe "expect inherit attributes from network" do
        it { expect(c_network.available_attributes).to include(:title, :description, :share_url) }

        describe "#title" do
          let(:network_attr) { :title }
          it_behaves_like "a config network attribute"
        end

        describe "#description" do
          let(:network_attr) { :title }
          it_behaves_like "a config network attribute"
        end

        describe "#share_url" do
          let(:network_attr) { :share_url }
          it_behaves_like "a config network attribute"
        end
      end

      describe "#app_id" do
        let(:network_attr) { :app_id }
        it_behaves_like "a config network attribute"
      end

      describe "#caption" do
        let(:network_attr) { :caption }
        it_behaves_like "a config network attribute"
      end

      describe "#provider" do
        let(:network_attr) { :provider }
        it_behaves_like "a config network attribute"
      end

      describe "#return_url" do
        let(:network_attr) { :return_url }
        it_behaves_like "a config network attribute"
      end

      describe "pass url params for context" do
        pending
      end
    end
  end
end
