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

  it "expect to get current context share context" do
    expect(params).to be_kind_of(SharingTags::ShareContext)
  end

  it "expect to exists twitter network" do
    expect(params.twitter).to be_kind_of(SharingTags::Network)
  end

  it "expect to receive default context twitter network title" do
    expect(params.twitter.title).to be == "main context network title"
  end

  it "expect to receive default context twitter network description" do
    expect(params.twitter.description).to be == "main context network desc"
  end

  it "expect to receive default context twitter network image" do
    expect(params.twitter.image).to be == "main context image"
  end

end