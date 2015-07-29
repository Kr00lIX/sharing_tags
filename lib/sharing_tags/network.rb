module SharingTags
  class Network < ConfigStorage
    ## default values
    ## ref to share context
    attr_accessor :image
    attr_reader :name

    def initialize(name, c_network)
      @name = name
      @c_network = c_network
      @share_context = c_network.share_context
      # @attributes = {}
      super()
    end

    # def image
    #   # get_value(:image)
    # end

    # `network name` params -> default network (some context) ->
    #    `network name` (main_context) ->  default network (main_context)

    # def parent
    #
    #   # @context
    # end
  end
end