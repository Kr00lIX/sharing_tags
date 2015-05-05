RSpec.describe MainController, :type => :controller  do
  render_views

  before do
    controller.append_view_path 'app/views'

    SharingTags.configure do

      # Activate default social network. Others available are:
      #  :vkontakte,
      #networks :twitter, :facebook, :google

      share_url_params(utm_source: "some_source", utm_campaign: "some_campaign")

      title "Sharing title for all networks"
      description "Change me at /path"
      image { image_url("http://test.host/images/social/default.jpg") }

      facebook do
        title "Facebook title"
      end

      google do
        description "Google description"
      end
    end
  end

  let(:sharing_tags) { controller.view_context.sharing_tags }

  describe "GET index" do
    before do
      get :index
    end

    it "expect render meta_tags" do
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
      expect(response).to render_template('sharing_tags/meta_tags.html.slim')
    end

    it "expect update default data for facebook"  do
      sharing_tags.facebook.tap do |facebook|
        expect(facebook.title).to eq("Facebook title")
        expect(facebook.description).to eq("Change me at /path")
        expect(facebook.image).to eq("http://test.host/images/social/default.jpg")
      end
    end

    it "expect default data for google" do
      sharing_tags.google.tap do |google|
        expect(google.title).to eq("Sharing title for all networks")
        expect(google.description).to eq("Google description")
        expect(google.image).to eq("http://test.host/images/social/default.jpg")
      end
    end

    it "expect default data for twitter" do
      sharing_tags.twitter.tap do |twitter|
        expect(twitter.title).to eq("Sharing title for all networks")
        expect(twitter.description).to eq("Change me at /path")
        expect(twitter.image).to eq("http://test.host/images/social/default.jpg")
      end
    end
  end

  #
  # describe "GET photo" do
  #   it "expect render meta_tags" do
  #     get :photo
  #     expect(response.status).to eq(200)
  #     expect(response).to render_template(:photo)
  #     expect(response).to render_template('sharing_tags/meta_tags')
  #
  #     sharing_tags.facebook.tap do |facebook|
  #       expect(facebook.title).to eq("Facebook title")
  #     end
  #   end
  # end
  #
  # describe "GET photo" do
  #   it "expect render meta_tags" do
  #     get :profile
  #     expect(response.status).to eq(200)
  #     expect(response).to render_template(:profile)
  #     expect(response).to render_template('sharing_tags/meta_tags')
  #   end
  # end

  describe "GET profile with switching context" do
    before do
      get :profile
    end

    it "expect render meta_tags" do
      expect(response.status).to eq(200)
      expect(response).to render_template(:profile)
      expect(response).to render_template('sharing_tags/meta_tags.html.slim')
    end
  end

  describe "Clear current context for each request to default" do
    pending "clear context to default"
  end
end