Rails.application.routes.draw do
  root 'posts#index'

  get :etag, to: 'caching_strategies#etag_caching'

  resources :posts, only: %i[index]
end
