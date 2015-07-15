module ApplicationHelper

  def route_name
    Rails.application.routes.router.recognize(request) do |route, _|
      return route.name
    end
  end

  def full_title(page_title)
    base_title = "Hihiring "
    page_title.empty? ?  base_title : page_title
  end

end
