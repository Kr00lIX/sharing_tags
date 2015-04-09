require "non-stupid-digest-assets"

module SharingTags::ActionView::AssetHelper

  def without_digest_asset_url(path, options = {})
    options.merge!(digested: false)

    add_image_to_non_digest_list(path)
    asset_url(path, options)
  end

  # redefine method Sprockets::Rails::Helper
  # Computes asset path to public directory.
  #
  # Override this method for non digested assets
  #
  def compute_asset_path(path, options = {})
    digested = options.delete(:digested)
    digested = true if digested.nil?

    if digest_path = asset_digest_path(path, options)
      path = digest_path if digested && digest_assets
      path += "?body=1" if options[:debug]
      File.join(assets_prefix || "/", path)
    else
      super
    end
  end

  private

  def add_image_to_non_digest_list(asset_name)
    return if ::NonStupidDigestAssets.whitelist.include?(asset_name)
    ::NonStupidDigestAssets.whitelist += [ asset_name ]
  end

end