module SharingTags
  class Config
    describe CContextMain do
      before do
        SharingTags.configure do
        end
      end

      let(:config) { SharingTags.config }

      it "expect instance of main context" do
        expect(config).to be_instance_of(SharingTags::Config)
      end

      describe "#networks" do
        it "expect define all networks by default" do
          SharingTags.configure do
          end
          expect(config.networks).to include(*CNetwork::AVAILABLE_NETWORKS)
        end

        it "expect receive defined networks" do
          SharingTags.configure do
            networks :twitter, :facebook
          end
          expect(config.networks).to include(:twitter, :facebook)
        end

        it "expect error if defined unavailable network" do
          expect { SharingTags.configure { networks :wrong_network_name } }.to raise_error(SharingTags::Config::CError)
        end
      end

      describe "#language" do
        it "expect define EN language by default" do
          SharingTags.configure do
          end
          expect(config.language).to be == "en"
        end

        it "expect change language to ru" do
          SharingTags.configure do
            language "ru"
          end
          expect(config.language).to be == "ru"
        end
      end
    end
  end
end