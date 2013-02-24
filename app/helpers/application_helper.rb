module ApplicationHelper
	include FacebookShare
  include TweetButton
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "YaleStarter"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def bitly 
    Bitly.use_api_version_3

    Bitly.new('o_242eiviqub', 'R_b4de4968f32af0cfe6f5b80b50b3e7b2')
  end
end