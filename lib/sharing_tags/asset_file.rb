module SharingTags
  class AssetFile
    class FileNotFound < IOError; end
    UNREADABLE_PATH = ''

    def self.named(filename)
      asset_path = FindsAssetPaths.by_filename(filename)
      File.read(asset_path || UNREADABLE_PATH)
    rescue Errno::ENOENT => e
      raise FileNotFound, "Asset not found: #{asset_path}: #{e}"
    end
  end
end