module SharingTags
  class Config
    describe CNetwork do
      let!(:config)  { Config.new }
      let!(:context) { CContext.new(:test, config) }
      let!(:c_network) { CNetwork.new(network_name, context) }
      let(:network_name) { CNetwork.lists.sample }
      let(:network) { context.share_context[network_name] }

      subject { c_network }

      it "expect get's list of available networks" do
        expect(CNetwork.lists).to include(:facebook, :twitter, :google, :vkontakte)
      end

      it "expect network name is a test" do
        expect(c_network.name).to be_eql(network_name)
      end

      describe "#title" do
        let(:network_attr) { :title }
        it_behaves_like "a config network attribute"
      end

      describe "#description" do
        let(:network_attr) { :description }
        it_behaves_like "a config network attribute"
      end

      describe "#share_url" do
        let(:network_attr) { :share_url }
        it_behaves_like "a config network attribute"
      end

      describe "#share_url_params" do
        # it { expect(network.available_attributes).to include(:share_url_params, :link_params) }
        it { expect(subject.available_attributes).to include(:share_url_params) }
      end

      # describe "#image" do
      #   let(:running_class_context) do
      #     Class.new do
      #       def some_helper(path)
      #         "helper/#{path}/done"
      #       end
      #
      #       def without_digest_asset_url(path)
      #         "non_digested/#{path}"
      #       end
      #     end
      #   end
      #
      #   before do
      #     config.running_context = running_class_context.new
      #   end
      #
      #   subject { network.attributes_for.image }
      #
      #   it "add network image through asset_url " do
      #     network.image "sharing/image.png"
      #     is_expected.to be_present
      #
      #     is_expected.to be == "sharing/image.png"
      #   end
      #
      #   it "define image by proc and run it in running_class_context" do
      #     network.image { some_helper("sharing/image.png") }
      #     is_expected.to be == "helper/sharing/image.png/done"
      #   end
      #
      #   it "expect path for full image attributes" do
      #     network.image "sharing/image.png", "100x500", "image/jpeg"
      #
      #     expect(network.attributes_for.image).to be == "sharing/image.png"
      #     expect(network.attributes_for.image_size).to be == [100, 500]
      #     expect(network.attributes_for.image_content_type).to be == "image/jpeg"
      #   end
      #
      #   xdescribe "non digested image" do
      #     it "expect non digested path for full image attributes" do
      #       network.image "sharing/image.png", "100x500", "image/jpeg", digested: false
      #
      #       expect(network.attributes_for.image).to be == "non_digested/sharing/image.png"
      #       expect(network.attributes_for.image_size).to be == [100, 500]
      #       expect(network.attributes_for.image_content_type).to be == "image/jpeg"
      #     end
      #
      #     it "expect correct image path without content type" do
      #       network.image "sharing/image.png", "100x500", digested: false
      #
      #       expect(network.attributes_for.image).to be == "non_digested/sharing/image.png"
      #       expect(network.attributes_for.image_size).to be == [100, 500]
      #       expect(network.attributes_for.image_content_type).to be_nil
      #     end
      #
      #     it "expect correct image path without content type and size" do
      #       network.image "sharing/image.png", digested: false
      #
      #       expect(network.attributes_for.image).to be == "non_digested/sharing/image.png"
      #       expect(network.attributes_for.image_size).to be_nil
      #       expect(network.attributes_for.image_content_type).to be_nil
      #     end
      #
      #     it "expect correct image path without content type and size" do
      #       network.image "sharing/image.png", digested: false
      #
      #       expect(network.attributes_for.image).to be == "non_digested/sharing/image.png"
      #       expect(network.attributes_for.image_size).to be_nil
      #       expect(network.attributes_for.image_content_type).to be_nil
      #     end
      #   end
      # end

      describe "#add_params_to_url" do

        subject { c_network.send(:add_params_to_url, @url, @params) }

        it "expect leave url without empty params" do
          @url = "http://sample.url"
          @params = nil
          is_expected.to be == @url
          is_expected.to be_html_safe
        end

        it "expect add params to url without params" do
          @url = "http://sample.url"
          @params = {a: 1, b: "unescaped_?&%_params"}
          is_expected.to be == "http://sample.url?a=1&b=unescaped_%3F%26%25_params"
          is_expected.to be_html_safe
        end

        it "expect add params and rewrite them for url with params" do
          @url = "http://sample.url?a=1&b=2"
          @params = {b: 4, c: 3}
          is_expected.to be == "http://sample.url?a=1&b=4&c=3"
          is_expected.to be_html_safe
        end

        it "expect add params for url with params" do
          @url = "http://sample.url?a=1&b=2"
          @params = {c: 3}
          is_expected.to be == "http://sample.url?a=1&b=2&c=3"
          is_expected.to be_html_safe
        end
      end
    end
  end
end