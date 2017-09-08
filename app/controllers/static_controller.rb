class StaticController < ApplicationController

  def page
    @page = StaticPage.find_by_page(params[:page])
    fresh_when(etag: @page, public: true)
  end

end
