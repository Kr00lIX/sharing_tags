require 'uri'

module SharingTags
  class Config
    class CNetworkBase
      # TODO: add default values

      AVAILABLE_NETWORKS = %i( facebook google twitter vkontakte odnoklassniki line linkedin )

      ATTRIBUTES = %i( title description share_url page_url share_url_params link_params
                       image_url image )

      attr_reader :name, :attributes, :network

      class Error < ::SharingTags::Config::CError
      end

      class_attribute :available_attributes

      class << self
        def lists
          AVAILABLE_NETWORKS
        end

        def network_class
          SharingTags::Network
        end

        def assign_to_network(attribute, aliases: [])
          define_method attribute do |value = nil, &block|
            @network.assign attribute, value, &block
          end

          # define getter method for network class
          network_class.define_attribute attribute

          self.available_attributes ||= []
          self.available_attributes << attribute

          # define aliases
          Array(aliases).each do |alias_name|
            self.available_attributes << alias_name
            define_method alias_name, &attribute
          end
        end
      end

      def initialize(name, context = nil)
        @name = name
        @context = context
        @share_context = context.share_context

        # add network to share context
        @network = (@share_context[@name] ||= self.class.network_class.new(name, parent.try(:network)))
      end
    end
  end
end