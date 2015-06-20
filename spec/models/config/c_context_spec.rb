class SharingTags::Config

  describe SharingTags::Config::CContext do
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
      let(:context) { SharingTags::Config::CContext.new(:foo, config) }

      it "expect save network attributes to default network" do
        expect { context.title "some title" }.to change { context.default_network.attributes[:title] }
      end

      it "expect raise error when try define unavailable network attribute" do
        expect { context.summary = "title" }.to raise_error(SharingTags::Config::CError)
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

      describe "#facebook" do
        let(:network) { context[:facebook] }

        it "expect instance of SharingTags::Config::ConfigNetworkFacebook " do
          expect(network).to be_instance_of(CNetworkFacebook)
        end
      end

      describe "#vkontakte" do
        let(:network) { context[:vkontakte] }

        it "expect instance of SharingTags::Config::ConfigNetwork" do
          expect(network).to be_instance_of(CNetwork)
        end
      end

      describe "#twitter" do
        let(:network) { context[:twitter] }

        it "expect instance of SharingTags::Config::ConfigNetwork" do
          expect(network).to be_instance_of(CNetwork)
        end
      end

      describe "#google" do
        let(:network) { context[:google] }

        it "expect instance of SharingTags::Config::ConfigNetwork" do
          expect(network).to be_instance_of(CNetwork)
        end
      end

      describe "#line" do
        let(:network) { context[:line] }

        it "expect instance of SharingTags::Config::ConfigNetwork" do
          expect(network).to be_instance_of(CNetwork)
        end
      end

      describe "#odnoklassniki" do
        let(:network) { context[:odnoklassniki] }

        it "expect instance of SharingTags::Config::ConfigNetwork" do
          expect(network).to be_instance_of(CNetwork)
        end
      end

      describe "#linkedin" do
        let(:network) { context[:linkedin] }

        it "expect instance of SharingTags::Config::ConfigNetwork" do
          expect(network).to be_instance_of(CNetwork)
        end
      end
    end

    describe "pass url params for context" do
      pending
    end
  end
end
