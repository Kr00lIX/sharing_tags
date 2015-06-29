# sharing_tags [![Gem Version](https://badge.fury.io/rb/sharing_tags.svg)](http://badge.fury.io/rb/sharing_tags) ![Build Status](https://circleci.com/gh/Kr00lIX/sharing_tags/tree/master.png?style=shield&circle-token=3d49c13a66c4bde62a4be235e2442b78d66c36de) ![Code Climate](https://codeclimate.com/github/Kr00lIX/sharing_tags/badges/gpa.svg) [![Coverage Status](https://coveralls.io/repos/Kr00lIX/sharing_tags/badge.svg)](https://coveralls.io/r/Kr00lIX/sharing_tags)


**sharing_tags** is a gem for adding social sharing buttons to your Rails app. 

Available for the following social networks: Facebook, Twitter, Odnoklassniki, Google Plus, Vkontakte, Line

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sharing_tags'
```

Run the bundle command to install it.

After you install SharingTags and add it to your Gemfile, you need to run the generator:

```ruby
rails generate sharing_tags:install
```

## Usage

This gem is a Rails 4+ compatible engine and now automatically includes all the view helper modules into ActionView::Base

### Views
For the simplest way of using this gem, add this helper method to head in your views:
```haml
    # generate meta tags for different social networks
    = sharing_meta_tags

    # render sharing buttons for networks
    = sharing_tags_buttons :facebook, :twitter, context: :user
```


### Example configuration
```ruby 
# initializers/sharings_tags.rb
SharingTags.configure do

    # global configuration
    title         "Global site title"
    description  "Global site description"
    page_url     { root_url }
    image        { image_url('img.jpg') }

    # for switch context call `sharing_tags_context(:user)` in controller action
    context :user do
        title         "User site title"
        description  "User site description"
        page_url     { profile_url }
    end
end
```

### Advanced configuration

```ruby  
# initializers/sharings_tags.rb
SharingTags.configure do

  facebook do
    app_id "APP ID"
  end

  twitter do
    title         "Twitter title"
    description { "Twitter description" }
    page_url     "http://a.b"
    image         "http://img.jpg"
  end

  facebook do
    title       { "Facebook title" }
    share_url   { "http://c.d" }
    image       "http://img.png", "100x200", "image/jpeg"
  end

  google do
    link_params utm_source: "google_source", utm_medium: "google_medium", utm_content: "google_content",
                utm_campaign: "google_campaign", marker: "google_marker"
  end

  # for switch context call `sharing_tags_context(:user, @user, @photo)` in controller action
  # or pass it in `sharing_tags_buttons context: [:user, @user, @photo]`
  context :user do
    title       { |user, photo| "Hello #{user.name}" }
    description { |user, photo| I18n.t("sharing.description", gender: user.gender) }
    image       { |user, photo| photo.image.url }

    twitter do
      title         "Twitter title"
    end
  end
end

```

### Javascript

You can subscribe to javascript events

```coffeescript
# click on sharing link
jQuery("body").on "sharing_tags.click_action", ({network, context, target})->
  # your code

# after successful sharing
jQuery("body").on "sharing_tags.shared", ({network, context, target})->
  # your code
```

### Wave-animations
''' sass
@import 'sharing_tags/wave_animation'

+create_wave_animation_on_sharing_buttons(4)
'''


## Recommendations
Facebook sharing images 1200x630 and add mimetype and size
    Best way for sharing sharer provider, but after sharing you stay on the post page
    + big images
    - after sharing stay on the post page in FB browser
    - can check sharing result in response

    fb_ui sharing everywhere
    + correct natively share in FB browser
    + return to page where called sharing
    + can check sharing result in responce
    - small images in the posts
    - have to create facebook application for app_id
    - doesn't work for iOS Chrome browser

    dialog
    + can redirect to another page after sharing
    + can check sharing result in responce
    - small images in the posts

    fb_ui_feed
    + can change sharing info without changing meta tags
    + big images
    + can check sharing result in responce
    - doesn't work in iOS FB browser
    - long time for load external big image


Vkontakte sharing images 537x240

Twitter Summary card images must be at least 120x120px 

## Tools for testing

Facebook Debugger (https://developers.facebook.com/tools/debug)

Google Structured Data Testing Tool (http://www.google.com/webmasters/tools/richsnippets)


## Contributing

1. Fork it ( https://github.com/Kr00lIX/sharing_tags/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## Copyright
Copyright © 2015 Anatolii Kovalchuk. See LICENSE.txt for further details.
