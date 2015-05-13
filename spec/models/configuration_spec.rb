describe SharingTags::Configuration do

  after do
    SharingTags.config.clear!
  end

  subject { SharingTags.config.params }

  describe "constants" do

    it "expect NETWORKS" do
      # expect(SharingTags::Configuration).to be_include(:twitter)
      # expect(SharingTags::Configuration).to has_include(:facebook)
    end

    it "expect defined version" do
      expect(SharingTags::VERSION).to be_truthy
    end
  end

  describe "define networks in default context" do
    before do
      SharingTags.configure do
        twitter do
          title         "Twitter title"
          description { "Twitter description" }
          page_url     "http://a.b"
          image         "http://img.jpg"
        end

        facebook do
          title { "Facebook title" }
          share_url   { "http://c.d" }
          image       {  "http://img.png" }
        end
      end
    end

    subject { SharingTags.config.params }

    it "expect found twitter" do
      params = subject[:twitter]
      expect(params).to be_truthy
      expect(params[:title]).to be == "Twitter title"
      expect(params[:description]).to be == "Twitter description"
      expect(params[:share_url]).to be == "http://a.b"
      expect(params[:page_url]).to be == "http://a.b"
      expect(params[:image]).to be == "http://img.jpg"
    end

    it "expect found facebook" do
      params = subject[:facebook]
      expect(params).to be_truthy
      expect(params[:title]).to be == "Facebook title"
      expect(params[:share_url]).to be == "http://c.d"
      expect(params[:image]).to be == "http://img.png"
    end

    it "not expect found google" do
      expect(subject.google).to be_blank
    end

  end

  describe "create new context" do
    before do
      SharingTags.configure do
        context :photo do
          google do
            title         "Photo title"
            description { "Photo description" }
            share_url     { |p1, p2| "http://#{p1}.#{p2}/" }
            image         "http://img.jpg"
          end
        end
      end
    end

    subject { SharingTags.config.params }

    it "expect not found default" do
      expect(subject.google).to be_blank
      expect(subject.facebook).to be_blank
      expect(subject.twitter).to be_blank
    end

    describe "switch context to photo" do
      before do
        SharingTags.config.switch_context(:photo, "param1", "param2")
      end

      it "expect new context data" do
        expect(subject[:google][:title]).to be == "Photo title"
        expect(subject[:google][:description]).to be == "Photo description"
        expect(subject[:google][:share_url]).to be == "http://param1.param2/"
      end
    end
  end

  describe "define utm params" do
    before do
      SharingTags.configure do
        share_url "http:://example.com"

        google do
          link_params utm_source: "google_source", utm_medium: "google_medium", utm_content: "google_content",
                      utm_campaign: "google_campaign", marker: "google_marker"
        end

        facebook do
          link_params utm_source: "facebook_source", utm_medium: "facebook_medium", utm_content: "facebook_content",
                      utm_campaign: "facebook_campaign", marker: "facebook_marker"
        end

        twitter do
          share_url "http:://for_twitter.com"

          link_params utm_source: "twitter_source", utm_medium: "twitter_medium"
        end
      end
    end

    it "expect add utm params to facebook share_url" do
      facebook_config = subject.facebook
      expect(facebook_config).to be_truthy
      expect(facebook_config.share_url).to be_include("http:://example.com")
      expect(facebook_config.share_url).to be_include("utm_campaign=facebook_campaign")
      expect(facebook_config.share_url).to be_include("utm_source=facebook_source")
      expect(facebook_config.share_url).to be_include("marker=facebook_marker")

      expect(facebook_config.share_url).to_not be_include("utm_source=google_source")
      expect(facebook_config.share_url).to_not be_include("utm_source=twitter_source")
    end

    it "expect add utm params to google share_url" do
      google_config = subject.google
      expect(google_config).to be_truthy
      expect(google_config.share_url).to be_include("http:://example.com")
      expect(google_config.share_url).to be_include("utm_campaign=google_campaign")
      expect(google_config.share_url).to be_include("utm_source=google_source")

      expect(google_config.share_url).to_not be_include("utm_campaign=facebook_campaign")
      expect(google_config.share_url).to_not be_include("utm_source=facebook_source")
      expect(google_config.share_url).to_not be_include("utm_source=twitter_source")

    end

    it "expect add utm params to twitter share_url" do
      twitter_config = subject.twitter
      expect(twitter_config).to be_truthy
      expect(twitter_config.share_url).to be_include("http:://for_twitter.com")
      expect(twitter_config.share_url).to be_include("utm_source=twitter_source")
      expect(twitter_config.share_url).to be_include("utm_medium=twitter_medium")

      expect(twitter_config.share_url).to_not be_include("utm_campaign")
      expect(twitter_config.share_url).to_not be_include("utm_source=google_source")
      expect(twitter_config.share_url).to_not be_include("utm_source=facebook_source")
      expect(twitter_config.share_url).to_not be_include("marker")
    end
  end

  describe "custom tags for networks" do
    before do
      SharingTags.configure do
        facebook do
          app_id "APP ID"
        end
      end
    end

    describe "switch context to photo" do

      it "expect new context data" do
        expect(subject[:facebook][:app_id]).to be == "APP ID"
      end
    end
  end
end