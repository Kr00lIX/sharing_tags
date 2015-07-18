describe SharingTags::ShareContext, "main context" do
  before do
    SharingTags.configure do

      networks :vkontakte, :google, :facebook, :linkedin

      title "main title"
      description "main desc"
      page_url "https://github.com/Kr00lIX/sharing_tags"

      google do
        description "google desc"
      end

      facebook do
        app_id "facebook app_id"
        caption "facebook caption"
        provider "facebook provider"
        return_url "facebook return_url"
        share_url_params(p1: "fb1", p2: "fb2")
      end

      linkedin do
        title     "Linkedin title"
        page_url  "http://linkedin.com"
      end
    end
  end

  let(:params) { SharingTags.params }
  let(:config) { SharingTags.config }

  describe "networks" do

    it "expect defined_networks" do
      expect(config.networks).to include(:vkontakte, :google, :facebook)
    end

  end

  describe "google" do
    subject { params.google }

    it { is_expected.to be_kind_of(SharingTags::Network)  }

    its(:title) { is_expected.to be == "main title" }
    its(:description) { is_expected.to be == "google desc" }
    its(:page_url) { is_expected.to be == "https://github.com/Kr00lIX/sharing_tags" }
  end

  describe "vkontakte" do
    subject { params.vkontakte }

    its(:title) { is_expected.to be == "main title" }
    its(:description) { is_expected.to be == "main desc" }
    its(:page_url) { is_expected.to be == "https://github.com/Kr00lIX/sharing_tags" }
  end

  describe "facebook" do
    subject { params.facebook }

    it { is_expected.to be_kind_of(SharingTags::Network::Facebook)  }
    its(:app_id) { is_expected.to be == "facebook app_id" }
    its(:caption) { is_expected.to be == "facebook caption" }
    its(:provider) { is_expected.to be == "facebook provider" }
    its(:return_url) { is_expected.to be == "facebook return_url" }

    its(:title) { is_expected.to be == "main title" }
    its(:description) { is_expected.to be == "main desc" }
    its(:page_url) { is_expected.to be == "https://github.com/Kr00lIX/sharing_tags" }
  end

  describe "linkedin" do
    subject { params.linkedin }

    its(:title) { is_expected.to be == "Linkedin title" }
    its(:description) { is_expected.to be == "main desc" }
    its(:page_url) { is_expected.to be == "http://linkedin.com" }
  end
end