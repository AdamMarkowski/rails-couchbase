class StaticController < ApplicationController

  def about
    @about = StaticPage.find_by_page('about')
    fresh_when(etag: @about, public: true)
  end

end
