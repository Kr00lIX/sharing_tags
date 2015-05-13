module SharingTags
  describe Network do
    let!(:config)  { Configuration.new }
    let!(:context) { Context.new(:test, config) }
    let!(:network) { Network.new(:test, context) }

    after do
      network.clear!
    end

    it "expect get's list of available networks" do
      expect(Network.lists).to include(:facebook, :twitter, :google, :vkontakte)
    end

    it "expect network name is a test" do
      expect(network.name).to be_eql(:test)
    end

    describe "#image" do
      let(:running_class_context) do
        Class.new do
          def some_helper(path)
            "helper/#{path}/done"
          end

          def without_digest_asset_url(path)
            "non_digested/#{path}"
          end
        end
      end

      before do
        config.running_context = running_class_context.new
      end

      subject { network.attributes_for.image }

      it "add network image through asset_url " do
        network.image "sharing/image.png"
        is_expected.to be_present

        is_expected.to be == "sharing/image.png"
      end

      it "define image by proc and run it in running_class_context" do
        network.image { some_helper("sharing/image.png") }
        is_expected.to be == "helper/sharing/image.png/done"
      end

      describe "non digested image" do
        it "expect non digested path for full image attributes" do
          network.image "sharing/image.png", "100x500", "image/jpeg", digested: false

          expect(network.attributes_for.image).to be == "non_digested/sharing/image.png"
          expect(network.attributes_for.image_size).to be == [100, 500]
          expect(network.attributes_for.image_content_type).to be == "image/jpeg"
        end

        it "expect correct image path without content type" do
          network.image "sharing/image.png", "100x500", digested: false

          expect(network.attributes_for.image).to be == "non_digested/sharing/image.png"
          expect(network.attributes_for.image_size).to be == [100, 500]
          expect(network.attributes_for.image_content_type).to be_nil
        end

        it "expect correct image path without content type and size" do
          network.image "sharing/image.png", digested: false

          expect(network.attributes_for.image).to be == "non_digested/sharing/image.png"
          expect(network.attributes_for.image_size).to be_nil
          expect(network.attributes_for.image_content_type).to be_nil
        end

        it "expect correct image path without content type and size" do
          network.image "sharing/image.png", digested: false

          expect(network.attributes_for.image).to be == "non_digested/sharing/image.png"
          expect(network.attributes_for.image_size).to be_nil
          expect(network.attributes_for.image_content_type).to be_nil
        end
      end
    end

  end
end