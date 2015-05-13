RSpec.describe SharingTags::ActionView::ButtonHelper, type: :helper do

  describe "#link_to_facebook_share" do
    before do
      SharingTags.configure do
        facebook do
          title "fb title"
          description "fb desc"
          share_url "http://c.d"
          page_url "http://a.b"
          image "http://img.png"
        end
      end
    end

    subject { helper.link_to_facebook_share }

    it "generate default text share link" do
      is_expected.to have_tag "a", with: {href: "http://a.b", role: "sharing_tags_share"}
      is_expected.to have_tag "a", with: {"data-share-url" => "http://c.d"}
      is_expected.to have_tag "img", with: {src: "/assets/sharing_tags/icons/facebook.svg"}

      is_expected.to have_tag("a", without: {
                                     "data-share-url" => "http://c.d",
                                     "data-title" => "fb title",
                                     "data-description" => "fb desc",
                                     "data-image" => "http://img.png",
                                     "data-network" => "facebook"
                                 })
    end

    it "generate default text sharing link for block" do
      expect(helper.link_to_facebook_share { "Text block" }).to have_tag "a", text: "Text block", with: {href: "http://a.b", role: "sharing_tags_share"}
      expect(helper.link_to_facebook_share { "Text block" }).to have_tag "a", text: "Text block", with: {"data-share-url" => "http://c.d"}
    end
  end

  describe "#link_to_vkontakte_share" do
    before do
      SharingTags.configure do
        vkontakte do
          title "vk title"
          description "vk desc"
          share_url "http://vk.share?utm_source=vk"
          page_url "http://vk.share"
          image "http://img.png"
        end
      end
    end

    subject { helper.link_to_vkontakte_share }

    it "generate default text share link" do
      is_expected.to have_tag "a", with: {href: "http://vk.share", role: "sharing_tags_share"}
      is_expected.to have_tag("a", with: {
                                     "data-share-url" => "http://vk.share?utm_source=vk",
                                     "data-title" => "vk title",
                                     "data-description" => "vk desc",
                                     "data-image" => "http://img.png",
                                     "data-network" => "vkontakte"
                                 })
    end

    it "generate default text sharing link for block" do
      expect(helper.link_to_vkontakte_share { "Text block" }).to have_tag "a", text: "Text block", with: {href: "http://vk.share", role: "sharing_tags_share"}
      expect(helper.link_to_vkontakte_share { "Text block" }).to have_tag("a", with: {
                                                                                 "data-share-url" => "http://vk.share?utm_source=vk",
                                                                                 "data-title" => "vk title",
                                                                                 "data-description" => "vk desc",
                                                                                 "data-image" => "http://img.png",
                                                                                 "data-network" => "vkontakte"
                                                                             })

    end
  end

  describe "#link_to_odnoklassniki_share" do
    before do
      SharingTags.configure do
        odnoklassniki do
          title "od title"
          description "od desc"
          share_url "http://od.share?utm_source=od"
          page_url "http://od.share"
          image "http://img.png"
        end
      end
    end

    subject { helper.link_to_odnoklassniki_share }

    it "generate default text share link" do
      is_expected.to have_tag "a", with: {href: "http://od.share", role: "sharing_tags_share"}
      is_expected.to have_tag("a", with: {
                                     "data-share-url" => "http://od.share?utm_source=od",
                                     "data-title" => "od title",
                                     "data-description" => "od desc",
                                     "data-network" => "odnoklassniki"
                                 })
      is_expected.to have_tag "img", with: {src: "/assets/sharing_tags/icons/odnoklassniki.svg"}
      is_expected.to have_tag("a", without: {
                                     "data-image" => "http://img.png"
                                 })
    end

    it "generate default text sharing link for block" do
      expect(helper.link_to_odnoklassniki_share { "Text block" }).to have_tag "a", text: "Text block", with: {href: "http://od.share", role: "sharing_tags_share"}
    end

    # it "generate default text sharing link for block" do
    #   pending
    #   expect(
    #       helper.link_to_odnoklassniki_share(role: "ya-target", data: {target: "main"}) { "Text" }
    #     ).to have_tag("a", text: "Text block",
    #                     with: {href: "http://od.share", role: "ya-target sharing_tags_share"})
    #
    #   expect(helper.link_to_odnoklassniki_share).to have_tag("a", with: {
    #                                                                 "data-share-url"   =>   "http://od.share?utm_source=od",
    #                                                                 "data-title"       =>   "od title",
    #                                                                 "data-description" =>   "od desc",
    #                                                                 'data-target'      =>   "main"
    #                                                             })
    # end
  end

  describe "#link_to_twitter_share" do
    before do
      SharingTags.configure do
        twitter do
          link_params utm_source: "tw"

          title "tw title"
          description "tw desc"
          page_url "http://tw.share"
          image "http://img.png"
        end
      end
    end

    subject { helper.link_to_twitter_share }

    it "generate default text share link" do
      is_expected.to have_tag "a", with: {href: "http://tw.share", role: "sharing_tags_share"}
      is_expected.to have_tag("a", with: {
                                     "data-share-url" => "http://tw.share?utm_source=tw",
                                     "data-title" => "tw title",
                                     "data-description" => "tw desc",
                                     "data-network" => "twitter"
                                 })
      is_expected.to have_tag("a", without: {"data-image" => "http://img.png"})
      expect(helper.link_to_twitter_share).to have_tag "img", with: {src: "/assets/sharing_tags/icons/twitter.svg"}
    end

    it "generate default text sharing link for block" do
      expect(helper.link_to_twitter_share { "Twitter block" }).to have_tag "a", text: "Twitter block", with: {href: "http://tw.share", role: "sharing_tags_share"}
    end
  end

  describe "#link_to_google_share" do
    before do
      SharingTags.configure do
        google do
          link_params utm_source: "gg"

          title "gg title"
          description "gg desc"
          page_url "http://gg.share"
          image "img.png"
        end
      end
    end

    subject { helper.link_to_google_share }

    it "generate default text share link" do
      is_expected.to have_tag "a", with: {href: "http://gg.share", role: "sharing_tags_share"}
      is_expected.to have_tag("a", with: {
                                     "data-share-url" => "http://gg.share?utm_source=gg",
                                     "data-network" => "google"
                                   },
                                   without: {
                                        "data-image" => "img.png",
                                        "data-title" => "gg title",
                                        "data-description" => "gg desc"
                                   })
      is_expected.to have_tag "img", with: {src: "/assets/sharing_tags/icons/google.svg"}
    end

    it "generate default text sharing link for block" do
      expect(helper.link_to_google_share { "Google block" }).to have_tag "a", text: "Google block", with: {href: "http://gg.share", role: "sharing_tags_share"}
    end
  end

  describe "#sharing_tags_buttons" do
    before do
      SharingTags.configure do
        title "Title"
        description "Desc"
        page_url "http://link.share"
        image "http://img.png"
      end
    end

    it "generate links with default networks" do
      expect(helper.sharing_tags_buttons).to have_tag "a"
      # have all network links
    end

    it "generate links for facebook, vkontakte, twitter" do
      expect(helper.sharing_tags_buttons).to have_tag "a"
    end

  end
end