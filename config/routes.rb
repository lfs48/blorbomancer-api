Rails.application.routes.draw do

  resources :users, only: [:show]

  resource :auth do
    post 'login'
    post 'register'
  end

end
