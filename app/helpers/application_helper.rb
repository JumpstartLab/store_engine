module ApplicationHelper

  def good_guide_image(badge_html)
    if badge_html
      badge_html
    else
      image_tag "/assets/na.jpeg"
    end
  end
end
