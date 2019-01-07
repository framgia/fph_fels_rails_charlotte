module CategoriesHelper
  def current_page?(state)
    if @page.eql?(state)
      "btn btn-default active"
    else
      "btn btn-default"
    end
  end
end