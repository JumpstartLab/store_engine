module ApplicationHelper

def render_flashes

    flash_types = [:notice, :warning, :message, :alert, :error]
    divs = []

    flash_types.each do |type|
      if flash[type]
        divs << "<div class=\"notice\">#{flash[type]}</div>"
      end
    end
    divs.join("\n").html_safe
  end
end
