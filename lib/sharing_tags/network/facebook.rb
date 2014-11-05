module SharingTags
  class Network::Facebook < Network

    def app_id(app_id = nil, &block)
      attributes[:app_id] = store_value(app_id, &block)
    end

  end

end