Rails.application.routes.draw do
  get 'posts/:path', to: 'posts#show'

  root 'root#index'
end
