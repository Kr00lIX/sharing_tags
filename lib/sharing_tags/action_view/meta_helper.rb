module SharingTags::ActionView::MetaHelper

  def sharing_tags
    SharingTags.config.within_context_params(self)
  end

  def render_sharing_tags
    render template: "sharing_tags/meta_tags"
  end
end