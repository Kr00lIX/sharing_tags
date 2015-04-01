
RSpec.describe "sharing_tags/meta_tags", :type => :view do

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
        end
      end
    end

    it "render image size tags" do
      render
      expect(rendered).to have_tag "meta", with: {property: "og:title",       content: "Facebook title"}
      expect(rendered).to have_tag "meta", with: {property: "og:description", content: "Facebook description"}
      expect(rendered).to have_tag "meta", with: {property: "og:image",       content: "http://img.jpg"}
      expect(rendered).to have_tag "meta", with: {property: "og:image:type",  content: "image/jpeg"}
      expect(rendered).to have_tag "meta", with: {property: "og:image:width", content: "100"}
      expect(rendered).to have_tag "meta", with: {property: "og:image:height",content: "200"}
      expect(rendered).to have_tag "meta", with: {property: "og:url",         content: "http://a.b"}
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
      expect(rendered).to have_tag "meta", with: {property: "og:title",       content: "Facebook title"}
      expect(rendered).to have_tag "meta", with: {property: "og:description", content: "Facebook description"}
      expect(rendered).to have_tag "meta", with: {property: "og:image",       content: "http://img.jpg"}
      expect(rendered).to have_tag "meta", with: {property: "og:image:type",  content: "image/jpeg"}
      expect(rendered).to have_tag "meta", with: {property: "og:image:width", content: "100"}
      expect(rendered).to have_tag "meta", with: {property: "og:image:height",content: "200"}
      expect(rendered).to have_tag "meta", with: {property: "og:url",         content: "http://a.b"}
    end
  end

end