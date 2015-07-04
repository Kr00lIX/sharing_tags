require "hashie/mash"

module SharingTags
  class ConfigStorage < ::Hashie::Mash
    # TODO: initialize default param as Config.new
    def self.network_attribute(name, default_value = nil, &default_proc)
      define_method name do
        get_value(name, default_value, &default_proc)
      end
    end

    def initialize
      @attributes = {}
      super
    end

    def assign(attribute, value, &proc_value)
      @attributes[attribute] = block_given? ? proc_value : value
    end

    protected

    def get_value(name, _default_value = nil, &_default_proc)
      value = @attributes[name]
      return value unless value.is_a?(Proc)

      if @context && @running_context
        # execute proc within the view context with context_params
        @running_context.instance_exec(*context_params, &value)
      else
        value.call(context_params)
      end
    end

    # # NOTE: temporary code for working construction sharing_tags.switch_context_to
    # def switch_context_to(name, *attrs)
    #   Rails.logger.debug "SharingTags: switch context from #{SharingTags.config.current_context.name} to #{name}"
    #   SharingTags.config.switch_context(name, *attrs)
    # end
    #
    # def divide_by_keys(lists)
    #   second_part = self.class.new
    #
    #   lists.each do |divide_key|
    #     second_part[divide_key] =
    #         if self.key?(divide_key)
    #           delete(divide_key)
    #         else
    #           self.class.new
    #         end
    #   end
    #
    #   [second_part, self]
    # end
    #
    # def get(*keys)
    #   dup.select { |key, _| keys.include?(key.to_sym) }
    # end
  end
end