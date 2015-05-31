module SharingTags
  class Config

    describe ConfigMainContext do
      before do
        SharingTags.configure do
          networks :twitter, :facebook
        end
      end

      let(:config) { SharingTags.config.main_context }

      it "expect instance of main context" do
        expect(config).to be_instance_of(ConfigMainContext)
      end

      describe "#networks" do
        it "expect define all networks by default" do
          SharingTags.configure do
          end
          expect(config.network_list).to include(*ConfigNetwork::AVAILABLE_NETWORKS)
        end

        it "expect receive defined networks" do
          SharingTags.configure do
            networks :twitter, :facebook
          end
          expect(config.network_list).to include(:twitter, :facebook)
        end

        it "expect error if defined unavailable network" do
          expect { SharingTags.configure { networks :wrong_network_name } }.to raise_error(SharingTags::Config::ConfigError)
        end
      end

      describe "#language" do
        xit "expect define EN language by default" do
          SharingTags.configure do
          end
          # binding.pry
          # expect(config).to include(*Network::AVAILABLE_NETWORKS)
        end

      end
    end
  end
end