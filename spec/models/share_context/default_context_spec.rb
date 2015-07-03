describe SharingTags::ShareContext, "default context"  ,:focus do
  before do
    SharingTags.configure do

      twitter do
        domain "twitter domain"
        site "twitter site"
        creator "twitter creator"
        card "twitter card"
        title  "twitter title"
        description "twitter desc"

        # share_url
        # page_url
        # share_url_params
      end

      facebook do
        app_id "facebook app_id"
        caption "facebook caption"
        provider "facebook provider"
        title  "facebook title"
        description "facebook desc"
        return_url "facebook return_url"
        share_url_params(p1: "fb1", p2: "fb2")
      end
    end
  end

  let(:params) { SharingTags.params }

  describe "twitter" do
    subject { params.twitter }

    it { is_expected.to be_kind_of(SharingTags::Network::Twitter)  }

    its(:title) { is_expected.to be ==  "twitter title" }
    its(:description) { is_expected.to be ==  "twitter desc" }

    its(:domain) { is_expected.to be ==  "twitter domain" }
    its(:site) { is_expected.to be == "twitter site" }
    its(:creator) { is_expected.to be == "twitter creator" }
    its(:card) { is_expected.to be == "twitter card" }
  end

  describe "facebook" do
    subject { params.facebook }

    it { is_expected.to be_kind_of(SharingTags::Network::Facebook)  }
    its(:app_id) { is_expected.to be ==  "facebook app_id" }
    its(:caption) { is_expected.to be ==  "facebook caption" }
    its(:provider) { is_expected.to be ==  "facebook provider" }
    its(:title) { is_expected.to be ==  "facebook title" }
    its(:description) { is_expected.to be ==  "facebook desc" }
    its(:return_url) { is_expected.to be ==  "facebook return_url" }
    its(:share_url_params) { is_expected.to include(p1: "fb1", p2: "fb2") }
  end

end