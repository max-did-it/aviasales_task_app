Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  defaults format: :json do
    resources :users do
      scope module: :users do
        resources :programs##, only: [:create, :show, :index] 
      end
    end
    resources :programs do
      collection do
        get 'search/:term', action: :search
      end
      scope module: :programs do
        member do
          patch '/users/ban'
        end
      end
    end
  end
end
