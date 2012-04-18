module ApplicationHelper
  # Bootstrap alert styles:
  #   alert alert-success alert-error alert-info
  def render_flashes
    flash_types     = [:notice, :warning, :message, :alert, :error]
    flash_class_map = {
      notice:  "alert",
      warning: "alert",
      message: "alert alert-success",
      alert:   "alert alert-error",
      error:   "alert alert-error"
    }
    divs = []

    flash_types.each do |type|
      if flash[type]
        divs <<
        <<-DIV
            <div class="#{flash_class_map[type]}">
              <a class="close" data-dismiss="alert">&#x00d7;</a>
              <strong>#{type.to_s.capitalize}:</strong> #{flash[type]}
            </div>
        DIV
      end
    end

    divs.join("\n").html_safe
  end
end
