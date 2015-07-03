module SharingTags
  class Network < ConfigStorage

    ## default values
    ## ref to share context

    attr_accessor :image

    # network_attribute :title
    # network_attribute :description
    # network_attribute :share_url
    # network_attribute :page_url
    # network_attribute :share_url_params

    def initialize(name, parent_network)
      @name = name
      @attributes = {}
      @parent_network = parent_network
      # @context = context
    end


    def image
      # get_value(:image)
    end


    private


    # get_dynamic_value


    # `network name` params -> default network (some context) ->
    #    `network name` (main_context) ->  default network (main_context)
  end
end