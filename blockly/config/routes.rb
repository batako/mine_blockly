Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  ActiveAdmin.routes(self)
  controller :authentication do
    post   'sign_in' => :sign_in
    delete 'sign_out' => :sign_out
  end

  resources :blocklies, only: [:index] do
    post 'run', on: :collection

    scope module: :blocklies do
      collection do
        resources :workspaces, except: [:index, :show] do
          resources :emotions, only: :update, param: :emotion, controller: 'workspaces/emotions'
        end
      end
    end
  end

  root to: 'authentication#index'
end
