class PageController < ApplicationController

  def show
    @page = Page.find_by_page(params[:page])
    fresh_when(etag: @page.cache_key, public: true)
  end

end
