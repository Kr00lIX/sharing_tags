require "hashie/mash"

module SharingTags
  class Config < ::Hashie::Mash

    # todo: initialize default param as Config.new

    # note: temporary code for working construction sharing_tags.switch_context_to
    def switch_context_to(name, *attrs)
      Rails.logger.debug "SharingTags: switch context from #{SharingTags.config.current_context.name} to #{name}"
      SharingTags.config.switch_context(name, *attrs)
    end

    def divide_by_keys(lists)
      second_part = self.class.new

      lists.each do |divide_key|
        second_part[divide_key] =
            if self.key?(divide_key)
              self.delete(divide_key)
            else
              self.class.new
            end
      end

      [second_part, self]
    end

  end
end