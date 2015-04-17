module SharingTags::ActionController::Helpers

  def sharing_tags
    SharingTags.config.within_context_params(view_context)
  end

  def sharing_tags_context(name, *attrs)
    SharingTags.config.switch_context(name, *attrs)
  end

end