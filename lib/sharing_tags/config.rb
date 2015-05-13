require "hashie/mash"

module SharingTags
  class Config < ::Hashie::Mash
    # TODO: initialize default param as Config.new

    # NOTE: temporary code for working construction sharing_tags.switch_context_to
    def switch_context_to(name, *attrs)
      Rails.logger.debug "SharingTags: switch context from #{SharingTags.config.current_context.name} to #{name}"
      SharingTags.config.switch_context(name, *attrs)
    end

    def divide_by_keys(lists)
      second_part = self.class.new

      lists.each do |divide_key|
        second_part[divide_key] =
            if self.key?(divide_key)
              delete(divide_key)
            else
              self.class.new
            end
      end

      [second_part, self]
    end

    def get(*keys)
      dup.select { |key, _| keys.include?(key.to_sym) }
    end
  end
end