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

    def get_value(name, default_value = nil, &default_proc)
      value = @attributes[name]
      return prepare_value(value) unless value.nil?

      if @parent
        @parent.get_value(name, default_value, &default_proc)
      else
        prepare_value(default_value) || prepare_value(default_proc)
      end
    end

    def prepare_value(value)
      if value.is_a? Proc
        value.call
      else
        value
      end  
    end  
  end
end