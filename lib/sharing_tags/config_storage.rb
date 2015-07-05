module SharingTags
  class ConfigStorage
    # TODO: initialize default param as Config.new
    def self.define_attribute(name, default_value = nil, &default_proc)
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

      # if @context && @running_context
      #   # execute proc within the view context with context_params
      #   @running_context.instance_exec(*context_params, &value)
      # else
      # value.call(context_params)
      value.call
      # end
    end
  end
end