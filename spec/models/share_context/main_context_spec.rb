describe SharingTags::ShareContext, "main context" do
  before do
    SharingTags.configure do

      title "main title"
      description "main desc"
      page_url "https://github.com/Kr00lIX/sharing_tags"

      twitter do
        description "twitter desc"
      end

      facebook do
        app_id "facebook app_id"
        caption "facebook caption"
        provider "facebook provider"
        title  "facebook title"
        return_url "facebook return_url"
        share_url_params(p1: "fb1", p2: "fb2")
      end

      # google do
      #   share_url    "http://google.com"
      # end
      #
      # vkontakte do
      #   title        "Vkontakte title"
      #   description  "Vkontakte desc"
      # end
      #
      # line do
      #   title        "Line title"
      # end
      #
      # odnoklassniki do
      #   title        "Odnoklassniki title"
      # end
      #
      # linkedin do
      #   title        "Linkedin title"
      # end
    end
  end

  let(:params) { SharingTags.params }

  describe "twitter" do
    subject { params.twitter }

    it { is_expected.to be_kind_of(SharingTags::Network::Twitter)  }

    # its(:title) { is_expected.to be == "main title" }
    # its(:description) { is_expected.to be == "twitter desc" }

    # its(:domain) { is_expected.to be == "twitter domain" }
    # its(:site) { is_expected.to be == "twitter site" }
    # its(:creator) { is_expected.to be == "twitter creator" }
    # its(:card) { is_expected.to be == "twitter card" }
  end
end