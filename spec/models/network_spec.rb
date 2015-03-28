describe SharingTags::Network do

  it "expect get's list of available networks" do
    expect(SharingTags::Network.lists).to include(:facebook, :twitter, :google, :vkontakte)
  end
end