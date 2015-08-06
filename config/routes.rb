Rails.application.routes.draw do

  devise_for :users
  
  root 'welcome#index'

  resources :wikis
  resources :charges, only: [:new, :create, :update]
	resources :users, only: [:show, :index] do
		  member do
				patch "downgrade"
			end
	end
end
