module ListsHelper
  def tag_class (tag)
    "active_tag" if session[:active_tags].include? tag[0]
  end
end
