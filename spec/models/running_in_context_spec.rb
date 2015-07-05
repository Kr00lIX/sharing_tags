describe SharingTags::Config do
  pending
  # before do
  #   SharingTags.configure do
  #     page_url { root_url }
  #     link_params { {utm_source: "#{network}_source", utm_campaign: "#{network}_#{context}"} }
  #
  #     twitter do
  #       title  { awesome_title }
  #     end
  #
  #     context :copyright do
  #       twitter do
  #         title  { |band| "#{awesome_title} (c) #{band}" }
  #       end
  #     end
  #   end
  # end
  #
  # let(:running_context) do
  #   Class.new do
  #     def root_url
  #       "http://example.com"
  #     end
  #
  #     def awesome_title
  #       "All you need is love"
  #     end
  #   end
  # end
  #
  # let(:params) { SharingTags.config.within_context_params(running_context.new) }
  #
  # describe "default context" do
  #   it "expect get twitter title from calling in running_context" do
  #     expect(params.twitter.title).to eql("All you need is love")
  #   end
  #
  #   it "expect get page_url from calling in running_context" do
  #     expect(params.twitter.page_url).to eql("http://example.com")
  #   end
  #
  #   xit "expect get share_url with assigned network name params" do
  #     expect(params.twitter.share_url).to include("http://example.com")
  #     expect(params.twitter.share_url).to include("utm_source=twitter_source")
  #     expect(params.twitter.share_url).to include("utm_campaign=twitter_default")
  #     expect(params.twitter.share_url).to include("utm_campaign").once
  #   end
  # end
  #
  # describe "copyright context" do
  #   before do
  #     SharingTags.config.switch_context(:copyright, "Beatles")
  #   end
  #
  #   it "expect get page_url from calling in running_context" do
  #     expect(params.twitter.title).to eql("All you need is love (c) Beatles")
  #   end
  #
  #   it "expect get twitter title from calling in running_context" do
  #     expect(params.twitter.page_url).to eql("http://example.com")
  #   end
  #
  #   xit "expect get share_url with assigned network name params" do
  #     expect(params.twitter.share_url).to include("http://example.com")
  #     expect(params.twitter.share_url).to include("utm_source=twitter_source")
  #     expect(params.twitter.share_url).to include("utm_campaign=twitter_copyright")
  #     expect(params.twitter.share_url).to include("utm_campaign").once
  #   end
  # end
end