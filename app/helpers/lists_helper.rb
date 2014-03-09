module ListsHelper
  def tag_class (tag)
    if session[:active_tags] and session[:active_tags].include? tag[0]
      "active_tag"
    end
  end
end
