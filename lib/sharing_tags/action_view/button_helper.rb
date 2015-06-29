module SharingTags
  module ActionView
    module ButtonHelper
      def sharing_tags_buttons(*networks, **options)
        networks = SharingTags::Network.lists if networks.empty?

        # switching context
        if options[:context].present?
          SharingTags.config.switch_context(*options[:context])  do
            context =  SharingTags.config.current_context
            render template: "sharing_tags/buttons.html.slim", locals: {networks: networks, options: options, context: context}
          end
        else
          context =  SharingTags.config.current_context
          render template: "sharing_tags/buttons.html.slim", locals: {networks: networks, options: options, context: context}
        end
      end

      def link_to_facebook_share(name_or_options = nil, &block)
        share_to name_or_options, :facebook, [:app_id, :provider, :title, :description, :caption, :image], &block
      end

      def link_to_vkontakte_share(name_or_options = nil, &block)
        share_to name_or_options, :vkontakte, [:title, :description, :image], &block
      end

      def link_to_line_share(name_or_options = nil, &block)
        share_to name_or_options, :line, [], &block
      end

      def link_to_google_share(name_or_options = nil, &block)
        share_to name_or_options, :google, [], &block
      end

      def link_to_odnoklassniki_share(name_or_options = nil, &block)
        share_to name_or_options, :odnoklassniki, [:title, :description], &block
      end

      def link_to_twitter_share(name_or_options = nil, &block)
        share_to name_or_options, :twitter, [:title, :description], &block
      end

      def link_to_linkedin_share(name_or_options = nil, &block)
        share_to name_or_options, :linkedin, [:title, :description], &block
      end

      private

      # TODO: enable Metrics/*
      # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/AbcSize
      def share_to(name_or_options = nil, network = nil, data_params = [], &block)
        params = sharing_tags[network]
        data_attrs = params.get(*(data_params + [:network, :share_url]))
        data_attrs[:context] = SharingTags.config.current_context.name

        classes = "sharing_tags-#{network}__icon sharing_tags-buttons__icon"

        if block_given?
          name_or_options = {} if !name_or_options || name_or_options.is_a?(String)
          data_attrs.merge!(name_or_options.delete(:data)) if name_or_options[:data]

          if name_or_options[:role]
            name_or_options[:role] += " sharing_tags_share"
          else
            name_or_options[:role] = "sharing_tags_share"
          end

          name_or_options[:class] ||= ""
          name_or_options[:class] << classes

          name_or_options.merge!(data: data_attrs, target: "_blank")

          link_to params.page_url, name_or_options, &block
        else

          link_to "",  params.page_url, data: data_attrs, role: "sharing_tags_share", class: classes, target: "_blank", &block
        end
      end
      # rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/AbcSize
    end
  end      
end