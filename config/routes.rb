Rails.application.routes.draw do
  root 'caching_strategies#index'

  get :etag, to: 'caching_strategies#etag_caching'
end
