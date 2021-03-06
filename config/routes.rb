Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :notes
      resources :labels
    end
  end
end
