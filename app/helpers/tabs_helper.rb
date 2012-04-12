module TabsHelper
  def tab_is_active?(path)
    request.fullpath == path ? "active" : ""
  end
end