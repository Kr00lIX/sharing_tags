describe SharingTags::ShareContext, :focus do
  before do
    SharingTags.configure do
      title "main context title"
      image "main context image"

      twitter do
        title  "main context network title"
        description "main context network desc"
      end

      context :foo do
        twitter do
          title  "foo context network title"
        end
      end
    end
  end

  let(:params) { SharingTags.config.pp }

  describe "default context" do
  end

  # describe "main context" do
  #   it "expect to receive default context twitter network title" do
  #     expect(params.twitter.title).to be == "main context network title"
  #   end
  # end

  describe "custom context" do

  end

  # describe "switch context" do
  #   it "expect to get current context share context" do
  #     expect(params).to be_kind_of(SharingTags::ShareContext)
  #   end
  # end
end