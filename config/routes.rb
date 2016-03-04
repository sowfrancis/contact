Rails.application.routes.draw do
  #devise routes
  devise_for :users,  :token_authentication_key => 'authentication_key'
  
  #customers routes
  resources :customers
  root "customers#index"
  post "customers/refresh_token" => "customers#refresh_token", as: 'refresh_path'
 
 # API routes
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:create, :index, :show], defaults: {format: :json}
    end
  end

  

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
