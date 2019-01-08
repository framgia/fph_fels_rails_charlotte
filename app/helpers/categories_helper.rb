module CategoriesHelper
  def current_page?(state)
    return "active" if @page.eql?(state)
  end
end