module SharingTags
  class Config    
    describe SharingTags::Config::CContext do
      describe "method missing" do
        let(:context) { SharingTags::Config::CContext.new(:foo, config) }
        let(:share_context) { context.share_context }

        it "expect save network attributes to default network" do
          expect(context.default_network).to receive(:title).with("some title")
          context.title "some title"
        end

        it "expect raise error when try define unavailable network attribute" do
          expect { context.aaa_bb_ccc_ddd = "title" }.to raise_error(SharingTags::Config::CError, /Available attributes/)
        end
      end

      describe "networks methods" do
        before do
          SharingTags.configure do
            twitter do
              title         "Twitter title"
            end

            facebook do
              title        "Facebook title"
            end

            google do
              title        "Google title"
            end

            vkontakte do
              title        "Vkontakte title"
            end

            line do
              title        "Line title"
            end

            odnoklassniki do
              title        "Odnoklassniki title"
            end

            linkedin do
              title        "Linkedin title"
            end
          end
        end

        let(:context) { SharingTags.config.main_context }
        let(:share_context) { context.share_context }
        let(:network) { context[network_name] }

        describe "#facebook" do
          let(:network_name) { :facebook }

          it "expect instance of SharingTags::Config::ConfigNetworkFacebook " do
            expect(network).to be_instance_of(CNetworkFacebook)
          end

          it_behaves_like "a config context attribute"
        end

        describe "#vkontakte" do
          let(:network_name) { :vkontakte }

          it "expect instance of SharingTags::Config::ConfigNetwork" do
            expect(network).to be_instance_of(CNetwork)
          end

          it_behaves_like "a config context attribute"
        end

        describe "#twitter" do
          let(:network_name) { :twitter }

          it "expect instance of SharingTags::Config::ConfigNetwork" do
            expect(network).to be_instance_of(CNetworkTwitter)
          end

          it_behaves_like "a config context attribute"
        end

        describe "#google" do
          let(:network_name) { :google }

          it "expect instance of SharingTags::Config::ConfigNetwork" do
            expect(network).to be_instance_of(CNetwork)
          end

          it_behaves_like "a config context attribute"
        end

        describe "#line" do
          let(:network_name) { :line }

          it "expect instance of SharingTags::Config::ConfigNetwork" do
            expect(network).to be_instance_of(CNetwork)
          end

          it_behaves_like "a config context attribute"
        end

        describe "#odnoklassniki" do
          let(:network_name) { :odnoklassniki }

          it "expect instance of SharingTags::Config::ConfigNetwork" do
            expect(network).to be_instance_of(CNetwork)
          end

          it_behaves_like "a config context attribute"
        end

        describe "#linkedin" do
          let(:network_name) { :linkedin }

          it "expect instance of SharingTags::Config::ConfigNetwork" do
            expect(network).to be_instance_of(CNetwork)
          end

          it_behaves_like "a config context attribute"
        end
      end
    end
  end  
end
