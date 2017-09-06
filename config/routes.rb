Rails.application.routes.draw do
  root 'posts#index'

  resources :posts, only: %i[index show] do
    get :add_rate, on: :member
    get :add_comment, on: :member
  end

  resources :static, only: %i[] do
    get :about, on: :collection
  end
end
