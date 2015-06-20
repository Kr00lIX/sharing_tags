module SharingTags
  class Network < ConfigStorage

    ## default values
    ## ref to share context

    attr_accessor :title
    attr_accessor :description
    attr_accessor :image


    def initialize(name, parent_network)
      @name = name
      @attributes = {}
      @parent_network = parent_network
      # @context = context
    end

    def share_url
    end

    def page_url
    end

    def image
      get_value(:image)
    end

    private

    # get_value
    def get_value(name)
      if @attributes[name]
        @attributes[name]
      elsif @parent_network
        @parent_network.get_value(name)
      else
        faile
      end
      # current network config
      #
    end

    # get_dynamic_value


    # `network name` params -> default network (some context) ->
    #    `network name` (main_context) ->  default network (main_context)
  end
end