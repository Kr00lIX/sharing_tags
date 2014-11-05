# SharingTags.configure do
#
#   # Activate default social network. Others available are:
#   #  :vkontakte,
#   #networks :twitter, :facebook, :google
#
#   share_url_params(utm_source: "some_source", utm_campaign: "some_campaign")
#
#   title "Sharing title for all networks"
#   description "Change me at /path"
#   image { image_url("social/default.jpg") }
#
#   facebook do
#     title "Facebook title"
#   end
#
#   google do
#     description "Google description"
#   end
#
#   #twitter do
#   #  share_url { "prepared_url" }
#   #  title       "twitter title"
#   #  description { "some description" }
#   #  image { image_url("social/twitter.jpg") }
#   #end
#   #
#   #
#   ## for switching context call: sharing_tags(:photo, @photo, @date)
#   #context :photo do
#   #  title { |photo, date| "Photo: #{photo.title}, #{date}" }
#   #
#   #  google do
#   #    share_url { |photo, _| photo_url(photo.id)}
#   #    image_url { |photo, _| photo.image.share.url }
#   #  end
#   #end
#   #
#   ## for switching context call: sharing_tags(:static)
#   #context :static do
#   #  title "Static page"
#   #  image "http://some/image.jpg"
#   #end
#
#   # sharing_tags.
#   #   .title
#   #   .image
#   #   .twitter
#   #     .title
#   #   .facebook
#   #     .desciption
#   #  sharing_tags.image
#   #
#   #  sharing_tags.to_a
#   #  sharing_tags.render_meta or sharing_tags.to_s
#
#   #sharing_tags.facebook_data
#   #sharing_tags.google_data
#   #sharing_tags.link_data.facebook
#   #
#
# end
