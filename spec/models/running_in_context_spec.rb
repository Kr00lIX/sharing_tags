describe SharingTags::Configuration do
  before do
    SharingTags.configure do
      page_url { root_url }

      twitter do
        title  { awesome_title }
      end

      context :copyright do
        twitter do
          title  { |band| "#{awesome_title} (c) #{band}" }
        end
      end
    end
  end

  let(:running_context) do
    Class.new do
      def root_url
        "context url"
      end

      def awesome_title
        "All you need is love"
      end
    end
  end

  let(:params) { SharingTags.config.within_context_params(running_context.new) }

  describe "default context" do
    it "expect get twitter title from calling in running_context" do
      expect(params.twitter.page_url).to eql("context url")
    end

    it "expect get page_url from calling in running_context" do
      expect(params.twitter.title).to eql("All you need is love")
    end
  end

  describe "copyright context" do
    before do
      SharingTags.config.switch_context(:copyright, "Beatles")
    end

    it "expect get page_url from calling in running_context" do
      expect(params.twitter.title).to eql("All you need is love (c) Beatles")
    end

    it "expect get twitter title from calling in running_context" do
      pending "copy default context for switched contexts"
      expect(params.twitter.page_url).to eql("context url")
    end
  end


end