class StaticController < ApplicationController

  def about
    @about = About.last
    fresh_when(etag: @about, public: true)
  end

end
