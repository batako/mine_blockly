Rails.application.routes.draw do
  resources :blocklies, only: [:index] do
    post 'run', on: :collection

    scope module: :blocklies do
      collection do
        resources :workspaces, except: [:index, :show]
      end
    end
  end

  root to: 'blocklies#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
