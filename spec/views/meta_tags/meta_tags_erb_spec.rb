RSpec.describe "sharing_tags/meta_tags", type: :view do
  pending
  # before do
  #   controller.append_view_path 'app/views'

  #   SharingTags.configure do
  #     share_url "http:://dummy.com"

  #     facebook do
  #       title           "Facebook title"
  #       description     "Facebook description"
  #       page_url        "http://a.b"
  #       image_url       "http://img.jpg"
  #     end

  #     google do
  #       title           "Google title"
  #       description     "Google description"
  #       page_url        "http://c.d"
  #       image_url       "http://img.png"
  #     end

  #     twitter do
  #       title           "Twitter title"
  #       description     "Twitter description"
  #     end
  #   end
  # end

  # let(:config) { SharingTags.config }

  # it "render open graph tags for Facebook" do
  #   render
  #   expect(rendered).to have_tag "meta", with: {property: "og:title",       content: "Facebook title"}
  #   expect(rendered).to have_tag "meta", with: {property: "og:description", content: "Facebook description"}
  #   expect(rendered).to have_tag "meta", with: {property: "og:image",       content: "http://img.jpg"}
  #   expect(rendered).to have_tag "meta", with: {property: "og:url",         content: "http://a.b"}
  # end

  # it "render schema tags for Google+" do
  #   render

  #   expect(rendered).to have_tag "meta", with: {itemprop: "name",           content: "Google title"}
  #   expect(rendered).to have_tag "meta", with: {itemprop: "description",    content: "Google description"}
  #   expect(rendered).to have_tag "meta", with: {itemprop: "image",          content: "http://img.png"}
  # end

  # it "render twitter card tags" do
  #   render

  #   expect(rendered).to have_tag "meta", with: {name: "twitter:card",        content: "summary"}
  #   # expect(rendered).to have_tag "meta", with: {name: "twitter:site",       content: ""}
  #   expect(rendered).to have_tag "meta", with: {name: "twitter:title",       content: "Twitter title"}
  #   expect(rendered).to have_tag "meta", with: {name: "twitter:description", content: "Twitter description"}
  #   # expect(rendered).to have_tag "meta", with: {name: "twitter:creator",    content: ""}
  #   # expect(rendered).to have_tag "meta", with: {name: "twitter:image:src",  content: ""}
  #   # expect(rendered).to have_tag "meta", with: {name: "twitter:domain",     content: ""}
  # end

  # it "expect render nothing with clear config" do
  #   config.clear!
  #   render
  #   expect(rendered).to_not have_tag('meta')
  # end
end
