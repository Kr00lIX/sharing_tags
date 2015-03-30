
RSpec.describe SharingTags::ActionView::Helpers, :type => :helper do

  before do
    SharingTags.configure do
      facebook do
        title        "fb title"
        description  "fb desc"
        share_url    "http://c.d"
        page_url     "#"
        image        "http://img.png"
      end
    end
  end

  describe "#sharing_tags" do
    pending
  end

  describe "#render_sharing_tags" do
    pending
  end

  describe "#link_to_facebook_share" do
    before do
      SharingTags.configure do
        facebook do
          title        "fb title"
          description  "fb desc"
          share_url    "http://c.d"
          page_url     "http://a.b"
          image        "http://img.png"
        end
      end
    end

    it "generate default text share link" do
      expect(helper.link_to_facebook_share).to have_tag "a", text: "Facebook", with: {href: "http://a.b", role: "sharing_tags_share"}
      expect(helper.link_to_facebook_share).to have_tag "a", with: {"data-share-url" => "http://c.d"}
      expect(helper.link_to_facebook_share).to have_tag "a", without: {"data-share-url" => "http://c.d"}
      expect(helper.link_to_facebook_share).to have_tag("a", without: {
                                                                "data-title"       =>   "fb title",
                                                                "data-description" =>   "fb desc",
                                                                "data-image"       =>   "http://img.png"
                                                            })
    end
  end

  describe "#link_to_vkontakte_share" do
    before do
      SharingTags.configure do
        vkontakte do
          title        "vk title"
          description  "vk desc"
          share_url    "http://vk.share?utm_source=vk"
          page_url     "http://vk.share"
          image        "http://img.png"
        end
      end
    end

    it "generate default text share link" do
      expect(helper.link_to_vkontakte_share).to have_tag "a", text: "Vkontakte", with: {href: "http://vk.share", role: "sharing_tags_share"}
      expect(helper.link_to_vkontakte_share).to have_tag("a", with: {
                                                             "data-share-url"   =>   "http://vk.share?utm_source=vk",
                                                             "data-title"       =>   "vk title",
                                                             "data-description" =>   "vk desc",
                                                             "data-image"       =>   "http://img.png"
                                                         })
    end
  end

  describe "#link_to_odnoklassniki_share" do
    before do
      SharingTags.configure do
        odnoklassniki do
          title        "od title"
          description  "od desc"
          share_url    "http://od.share?utm_source=od"
          page_url     "http://od.share"
          image        "http://img.png"
        end
      end
    end


    it "generate default text share link" do
      expect(helper.link_to_odnoklassniki_share).to have_tag "a", text: "Odnoklassniki", with: {href: "http://od.share", role: "sharing_tags_share"}
      expect(helper.link_to_odnoklassniki_share).to have_tag("a", with: {
                                                             "data-share-url"   =>   "http://od.share?utm_source=od",
                                                             "data-title"       =>   "od title",
                                                             "data-description" =>   "od desc"
                                                         })
      expect(helper.link_to_odnoklassniki_share).to have_tag("a", without: {
                                                                    "data-image" => "http://img.png"
                                                                })
    end
  end
end