module SharingTags::ActionController::Helpers

  def sharing_tags
    SharingTags.config.within_context_params(view_context)
  end

end