describe SharingTags::ShareContext, "custom context" do
  before do
    SharingTags.configure do

      networks :google, :facebook

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
        title  "facebook title"
        return_url "facebook return_url"
        share_url_params(p1: "fb1", p2: "fb2")
      end

      context :custom do
        title "custom context title"

        google do
        end
      end

      context :some do
        facebook do
          title "facebook title some context "
        end
      end
    end
  end

  let(:params) { SharingTags.params(@context) }

  describe "custom context" do
    before do
      @context = :custom
    end

    describe "google" do
      subject { params.google }

      it { is_expected.to be_kind_of(SharingTags::Network)  }

      its(:title) { is_expected.to be == "custom context title" }
      its(:description) { is_expected.to be == "google desc" }
    end

    describe "facebook" do
      subject { params.facebook }

      it { is_expected.to be_kind_of(SharingTags::Network::Facebook)  }
      its(:title) { is_expected.to be == "custom context title" }
      its(:description) { is_expected.to be == "main desc" }
      its(:caption) { is_expected.to be == "facebook caption" }
    end
  end

  describe "some context" do
    before do
      @context = :some
    end

    describe "google" do
      subject { params.google }

      its(:title) { is_expected.to be == "main title" }
      its(:description) { is_expected.to be == "google desc" }
    end
  end

  describe "facebook" do
    subject { params.facebook }

    its(:title) { is_expected.to be == "facebook title" }
    its(:description) { is_expected.to be == "main desc" }
    its(:caption) { is_expected.to be == "facebook caption" }
  end
end