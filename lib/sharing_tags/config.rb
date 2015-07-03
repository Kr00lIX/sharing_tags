module SharingTags
  class Config
    attr_accessor :running_context
    attr_accessor :asset_finder
    attr_reader :main_context

    def initialize
      clear!
    end

    def context(name, &block)
      fail "please define context block params" unless block_given?
      (@contexts[name] ||= CContext.new(name, self, main_context)).instance_exec(&block)
    end

    # def switch_context(name = nil, *args, &block)
    #   clean_params!
    #   prev_context = current_context
    #   prev_context_params = @current_context_params
    #
    #   @current_context_params = args
    #   @current_context = name && @contexts[name] || main_context
    #   return unless block_given?
    #
    #   result = block.call
    #
    #   @current_context = prev_context
    #   @current_context_params = prev_context_params
    #
    #   result
    # end
    # alias_method :switch_context_to, :switch_context

    def clear!
      @contexts = {}
      @main_context = CMainContext.new(:default, self)
      @current_context = nil
      @running_context = nil
      clean_params!
    end

    # todo: move to private or another class
    # move to private or another class
    # new realisation of params
    def pp
      current_context.share_context
    end

    # todo: move to private or another class
    def params
      # @params ||= fetch_params
      # todo: deprecated
      @params = fetch_params
    end

    def within_context_params(running_context_instance)
      @running_context = running_context_instance
      params
    end

    # move to private or another class
    def current_context
      @current_context || main_context
    end

    private

    def clean_params!
      @params = nil
    end

    def clear_context!
      @current_context = nil
    end

    def fetch_params
      main_context_params = main_context.params(@current_context_params)
      return main_context_params unless @current_context
      @current_context.params(@current_context_params, main_context_params)
    end

    def method_missing(method_name, *arguments, &block)
      current_context.send(method_name, *arguments, &block)
    end
  end
end