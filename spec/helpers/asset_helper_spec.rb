require "non-stupid-digest-assets"

RSpec.describe SharingTags::ActionView::AssetHelper, type: :helper do

  describe "#without_digest_asset_url" do
    before do
      SharingTags.configure do
        image        "http://img.png"
      end
    end

    let(:image) { "image_path/image.png" }

    subject { helper.without_digest_asset_url(image) }

    it "expect exist method" do
      expect(helper).to be_respond_to(:without_digest_asset_url)
    end

    it "expect return non digested url" do
      is_expected.to be_eql("http://test.host/images/image_path/image.png")
    end

    it "add to non digest gem" do
      NonStupidDigestAssets.whitelist = []
      expect { is_expected }.to change(::NonStupidDigestAssets, :whitelist)
    end
  end

end