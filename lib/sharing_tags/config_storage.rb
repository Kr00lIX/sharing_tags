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
    end

    def assign(attribute, value, &proc_value)
      @attributes[attribute] = block_given? ? proc_value : value
    end

    protected

    def running_context
      @running_context ||= SharingTags::Network::RunningContext.new(self, @share_context)
    end

    def get_value(name, default_value = nil, &default_proc)
      # self network in context ->
      #   default network in context ->
      #   network in main context ->
      #   default network in  main context
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
        running_context.instance_exec(*@share_context.context_params, &value)
      else
        value
      end  
    end  
  end
end