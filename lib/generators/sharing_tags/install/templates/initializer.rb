# This file was generated by the `rails generate sharing_tags:install` command.

SharingTags.configure do

  ## default data

  title         "Global site title"
  description   "Global site description"
  page_url      { root_url }
  image         { image_url('img.jpg') }

  # # add additional arguments to each sharing url
  # share_url_params utm_source: "sharing_tags"

  # social network specific data
  # facebook do
  #   app_id "123"
  #   title "Facebook sharing title"
  # end
  #
  # twitter do
  #   title "Short title"
  #   description "Page description less than 200 characters"
  #   image "images must be at least 120x120px"
  # end

  # # for switch context call `sharing_tags_context(:user)` in controller action
  # context :user do
  #   title         "User site title"
  #   description  "User site description"
  #   page_url     { users_url }
  # end

  # # for switch context with params call `sharing_tags_context(:car, @user, @car)` in controller action
  # # or pass it in `sharing_tags_buttons context: [:user, @user, @photo]`
  # context :car do
  #   title        { |user, car| "#{user.name} drive on #{car.name}" }
  #   description  { |_, car| car.description  }
  #   page_url     { profile_url }
  # end

  # context :shakespeare do
  #   title "Shakespeare quote"
  #   page_url "http://www.brainyquote.com/quotes/authors/w/william_shakespeare.html"
  #
  #   facebook do
  #     description "We know what we are, but know not what we may be."
  #   end
  #
  #   vkontakte do
  #     description "Love all, trust a few, do wrong to none."
  #   end
  #
  #   twitter do
  #     description "Better three hours too soon than a minute too late."
  #   end
  #
  #   line do
  #     description "If music be the food of love, play on."
  #   end
  #
  #   odnoklassniki do
  #     description "Hell is empty and all the devils are here"
  #   end
  #
  #   google do
  #     description "To do a great right do a little wrong."
  #   end
  # end

end