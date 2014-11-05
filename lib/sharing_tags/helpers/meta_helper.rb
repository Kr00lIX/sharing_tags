module SharingTags::MetaHelper

  def sharing_tags
    SharingTags.config.params
  end

  def render_sharing_tags
    render template: "sharing_tags/meta_tags"
  end

end