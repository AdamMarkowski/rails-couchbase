class PageController < ApplicationController

  def show
    @page = Page.find_by_page(params[:page])
    fresh_when(etag: @page, public: true)
  end

end
