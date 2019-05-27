module CommentsHelper
  def get_avatar_url user_id
    user = User.find_by(id: user_id)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = Settings.gravatar_size
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    # image_tag(gravatar_url, alt: user.name, class: "gravatar")
    return gravatar_url
  end

  def get_response root_id
    @comment_responses = Comment.where(comment_id: root_id)
  end
end
