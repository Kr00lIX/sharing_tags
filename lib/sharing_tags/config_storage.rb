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
      @c_network.self_and_parents do |c_network|
        value = c_network.network.fetch_value(name)
        return value if value.present?
      end

      prepare_value(default_value) || prepare_value(default_proc)
    end

    def fetch_value(name)
      value = @attributes[name]
      prepare_value(value) unless value.nil?
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