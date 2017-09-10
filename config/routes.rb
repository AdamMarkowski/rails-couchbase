Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'posts#index'

  resources :posts, only: %i[index show] do
    get :add_rate, on: :member
    get :add_comment, on: :member
  end

  get '/page/:page', to: 'page#show', as: :page
end
