
RSpec.describe SharingTags::ActionView::MetaHelper, type: :helper do

  describe "#sharing_tags" do
    pending
  end

  describe "#sharing_meta_tags" do
    before do
      SharingTags.configure do
        title        "Sharing title"
        description  "Sharing description"
        page_url     "http://a.b"
        image        "http://img.png"
      end
    end

    it "generate open graph meta tags" do
      expect(helper.sharing_meta_tags).to have_tag "meta", with: {property: "og:title", content: "Sharing title"}
      expect(helper.sharing_meta_tags).to have_tag "meta", with: {property: "og:description", content: "Sharing description"}
      expect(helper.sharing_meta_tags).to have_tag "meta", with: {property: "og:image", content: "http://img.png"}
    end

    it "generate schema meta tags" do
      expect(helper.sharing_meta_tags).to have_tag "meta", with: {itemprop: "name",        content: "Sharing title"}
      expect(helper.sharing_meta_tags).to have_tag "meta", with: {itemprop: "description", content: "Sharing description"}
      expect(helper.sharing_meta_tags).to have_tag "meta", with: {itemprop: "image",       content: "http://img.png"}
    end

    it "generate twitter card meta tags" do
      expect(helper.sharing_meta_tags).to have_tag "meta", with: {name: "twitter:title",       content: "Sharing title"}
      expect(helper.sharing_meta_tags).to have_tag "meta", with: {name: "twitter:description", content: "Sharing description"}
    end
  end
end