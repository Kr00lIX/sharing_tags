class MainController < ApplicationController

  def index
  end

  def photo
    @photo = ::Hashie::Mash.new(photo: "best_photo")
    sharing_tags.switch_context_to(:photo, @photo)

    # view_context.sharing_tags.switch_context_to(:gallery, @photo)
    # sharing_tags(:photo, @photo)

    # sharing_tags.switch_context_to(:photo, p1: @photo, p2: @object2)
    # sharing_tags.switch_context_to(:photo, @photo )
    # sharing_tags(:photo, @photo, title: "Default title", facebook: {title: "Facebook Title"}) # ?
    # render sharing_tags.to_s # render meta tags
  end

  def profile
    @user = ::Hashie::Mash.new(birthday: Date.parse("1969-12-28"), name: "Linus")
    sharing_tags.switch_context_to(:profile, @user)

  end

end