module SharingTags
  class Network < ConfigStorage
    ## default values
    ## ref to share context
    attr_accessor :image
    attr_reader :name

    # network_attribute :title
    # network_attribute :description
    # network_attribute :share_url
    # network_attribute :page_url
    # network_attribute :share_url_params

    def initialize(name, c_network)
      @name = name
      @c_network = c_network
      @share_context = c_network.share_context
      # @attributes = {}
      super()
    end

    def image
      # get_value(:image)
    end

    # `network name` params -> default network (some context) ->
    #    `network name` (main_context) ->  default network (main_context)
    # def method_missing(method_name, *arguments, &block)
    #   # @parent_network.send(method_name, *arguments, &block)
    # end

    # def parent
    #   # self network in context
    #   # default network in context
    #   # network in main context
    #   # default network in  main context
    #
    #   # @context
    # end
  end
end