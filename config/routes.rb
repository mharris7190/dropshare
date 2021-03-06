Dropshare::Application.routes.draw do
  get "activities/index"
  resources :drop_files, only: [:new, :create, :destroy]
  resources :users
  resources :groups
  resources :activities

  root 'static_pages#index'
  
  get "drive/login"
  get "drive/upload"
  get "drive/download"
  get "drive/logout"
  
  match "/auth/facebook", to: 'sessions#create', via: [:get, :post]
    
  # To link facebook 
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  match ':user_id/friendlists', to: 'sessions#create', via: [:get]
  # redirect to feed after login
  match 'feed', to: 'users#feed', via: [:get, :post]
  # user wall
  match 'wall', to: 'users#wall', via: [:get, :post]

  #creating friend groups
  match 'createGroup', to: 'groups#create_group', via: [:get, :post]

  match 'destroyGroup', to: 'groups#destroy', via: [:get, :post]


  #static_pages
  match '/about', to: 'static_pages#about', via: [:get]
  match '/contact', to: 'static_pages#contact', via: [:get]
  match '/help', to: 'static_pages#help', via: [:get]
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

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
