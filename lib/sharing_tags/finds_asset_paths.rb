module SharingTags
  class FindsAssetPaths
    def self.by_filename(filename)
      asset = configured_asset_finder.find_asset(filename)
      asset && asset.pathname
    end

    def self.configured_asset_finder
      SharingTags.config.asset_finder
    end
  end
end