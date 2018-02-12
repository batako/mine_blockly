Rails.application.routes.draw do
  resources :blockly, only: [:index] do
    post 'run', on: :collection
  end

  root to: 'blockly#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
