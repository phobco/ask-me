module QuestionsHelper
  def make_hashtags_clickable(string)
    string.gsub(Hashtag::REGEX) { |hashtag| link_to hashtag, hashtag_path(hashtag.delete('#').downcase) }.html_safe
  end
end
