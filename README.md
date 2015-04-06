# sharing_tags [![Gem Version](https://badge.fury.io/rb/sharing_tags.svg)](http://badge.fury.io/rb/sharing_tags) ![Build Status](https://secure.travis-ci.org/Kr00lIX/sharing_tags.svg?branch=master) ![Code Climate](https://codeclimate.com/github/Kr00lIX/sharing_tags/badges/gpa.svg) ![Security](https://hakiri.io/github/Kr00lIX/sharing_tags/master.svg)  [![Coverage Status](https://coveralls.io/repos/Kr00lIX/sharing_tags/badge.svg)](https://coveralls.io/r/Kr00lIX/sharing_tags)


**sharing_tags** is a gem for adding social sharing buttons to your Rails app. 

Available for the following social networks: Facebook, Twitter, Odnoklassniki, Google Plus, Vkontakte

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sharing_tags', github: 'Kr00lIX/sharing_tags'
```

Run the bundle command to install it.

After you install SharingTags and add it to your Gemfile, you need to run the generator:

```ruby
rails generate sharing_tags:install
```

## Usage

### Views
For the simplest way of using this gem, add this helper method to head in your views:
```haml
    # generate meta tags for different social networks
    = render_sharing_tags
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

    # for switch context call `sharing_tags.switch_context_to(:user)` in controller action
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

  # for switch context call `sharing_tags.switch_context_to(:user, @user, @photo)` in controller action
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

## Tools for testing

Facebook Debugger (https://developers.facebook.com/tools/debug)

Google Structured Data Testing Tool (http://www.google.com/webmasters/tools/richsnippets)


## Contributing

1. Fork it ( https://github.com/[my-github-username]/sharing_tags/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Copyright
Copyright © 2015 Anatolii Kovalchuk. See LICENSE.txt for further details.
