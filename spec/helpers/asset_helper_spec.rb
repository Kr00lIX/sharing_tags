RSpec.describe SharingTags::ActionView::AssetHelper, :type => :helper do

  describe "#without_digest_assets_url" do
    before do
      SharingTags.configure do
        title        "Sharing title"
        description  "Sharing description"
        page_url     "http://a.b"
        image        "http://img.png"
      end
    end

    it "expect" do
      expect(helper).to be_respond_to(:without_digest_assets_url)
    end
  end
end