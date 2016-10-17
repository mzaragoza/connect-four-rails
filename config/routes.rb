Rails.application.routes.draw do

  resources :games do
    resources :players do
      resources :moves
    end
  end
  root 'games#index'
end
