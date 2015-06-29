
RSpec.describe "sharing_tags/meta_tags", type: :view do

  context "constant params" do
    before do
      controller.append_view_path 'app/views'

      SharingTags.configure do
        share_url "http:://dummy.com"

        facebook do
          title           "Facebook title"
          description     "Facebook description"
          page_url        "http://a.b"
          image_url       "http://img.jpg", "100x200", "image/jpeg"
          app_id          "12345"
        end
      end
    end

    it "render image size tags" do
      render
      expect(rendered).to have_tag "meta", with: {property: "og:title",        content: "Facebook title"}
      expect(rendered).to have_tag "meta", with: {property: "og:description",  content: "Facebook description"}
      expect(rendered).to have_tag "meta", with: {property: "og:image",        content: "http://img.jpg"}
      expect(rendered).to have_tag "meta", with: {property: "og:image:type",   content: "image/jpeg"}
      expect(rendered).to have_tag "meta", with: {property: "og:image:width",  content: "100"}
      expect(rendered).to have_tag "meta", with: {property: "og:image:height", content: "200"}
      expect(rendered).to have_tag "meta", with: {property: "og:url",          content: "http://a.b"}
      expect(rendered).to have_tag "meta", with: {property: "fb:app_id",       content: "12345"}
    end
  end

  context "constant params" do
    before do
      controller.append_view_path 'app/views'

      SharingTags.configure do
        share_url "http:://dummy.com"

        facebook do
          title          { "Facebook title" }
          description    { "Facebook description" }
          page_url       { "http://a.b" }
          image_url("100x200", "image/jpeg")      { "http://img.jpg" }
        end
      end
    end

    it "render image size tags" do
      render
      expect(rendered).to have_tag "meta", with: {property: "og:title",        content: "Facebook title"}
      expect(rendered).to have_tag "meta", with: {property: "og:description",  content: "Facebook description"}
      expect(rendered).to have_tag "meta", with: {property: "og:image",        content: "http://img.jpg"}
      expect(rendered).to have_tag "meta", with: {property: "og:image:type",   content: "image/jpeg"}
      expect(rendered).to have_tag "meta", with: {property: "og:image:width",  content: "100"}
      expect(rendered).to have_tag "meta", with: {property: "og:image:height", content: "200"}
      expect(rendered).to have_tag "meta", with: {property: "og:url",          content: "http://a.b"}
    end
  end

  describe "doesn't render empty params" do
    before do
      controller.append_view_path 'app/views'

      SharingTags.configure do
        share_url "http:://dummy.com"

        facebook do
          caption       { "Facebook caption" }
          image_url     { "http://img.jpg" }
        end
      end
    end

    it "render caption instead title" do
      render
      expect(rendered).to have_tag "meta", with: {property: "og:title",        content: "Facebook caption"}
    end

    it "expect render image meta" do
      render
      expect(rendered).to have_tag "meta", with: {property: "og:image",        content: "http://img.jpg"}
    end

    it "shouldn't render empty params" do
      render
      expect(rendered).to_not have_tag "meta", with: {property: "og:description"}
      expect(rendered).to_not have_tag "meta", with: {property: "og:image:type"}
      expect(rendered).to_not have_tag "meta", with: {property: "og:image:width"}
      expect(rendered).to_not have_tag "meta", with: {property: "og:image:height"}
    end
  end
end