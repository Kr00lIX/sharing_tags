require "non-stupid-digest-assets"

RSpec.describe SharingTags::ActionView::AssetHelper, :type => :helper do

  describe "#without_digest_assets_url", :focus do
    before do
      SharingTags.configure do
        title        "Sharing title"
        description  "Sharing description"
        page_url     "http://a.b"
        image        "http://img.png"
      end
    end

    let(:image) { "image_path/image.png" }

    it "expect exist method" do
      expect(helper).to be_respond_to(:without_digest_assets_url)
    end

    it "expect return non digested url" do
      expect(helper.without_digest_assets_url(image)).to be_eql("http://test.host/image_path/image.png")

    end

    it "add to non digest gem" do
      expect{ helper.without_digest_assets_url(image) }.to change(::NonStupidDigestAssets, :whitelist)
    end
  end
end