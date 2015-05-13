module SharingTags
  class Configuration
    NETWORKS = %i( google facebook twitter )

    attr_accessor :running_context
    attr_reader :default_context

    def initialize
      clear!
    end

    def context(name, &block)
      fail "please define context block params" unless block_given?
      (@contexts[name] ||= Context.new(name, self)).instance_exec(&block)
    end

    def switch_context(name = nil, *args)
      clean_params!
      @current_context_params = args
      @prev_context = current_context

      @current_context =
        if name
          @contexts[name]
        else
          default_context
        end
    end
    alias_method :switch_context_to, :switch_context

    def clear!
      @contexts = {}
      @default_context = Context.new(:default, self)
      @current_context = nil
      @running_context = nil
      clean_params!
    end

    def params
      # @params ||= fetch_params
      @params = fetch_params
    end

    def within_context_params(running_context_instance)
      @running_context = running_context_instance
      params
    end

    def current_context
      @current_context || default_context
    end

    def clean_params!
      @params = nil
    end

    def clear_context!
      @current_context = nil
    end

    private

    def fetch_params
      default_context_params = default_context.params(@current_context_params)
      return default_context_params unless @current_context
      @current_context.params(@current_context_params, default_context_params)
    end

    def method_missing(method_name, *arguments, &block)
      current_context.send(method_name, *arguments, &block)
    end
  end
end