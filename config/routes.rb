Rails.application.routes.draw do

  get "users_institutions/create"
  namespace :front do

    root to: 'homes#index'

  end

  scope '/admin' do
    devise_for :users, :controllers => {
        :invitations => 'admin/users/invitations',
        :sessions => 'admin/users/sessions',
        :registrations => 'admin/users/registrations',
        :confirmations => 'admin/users/confirmations',
        :passwords => 'admin/users/passwords',
        :unlocks => 'admin/users/unlocks',
        :omniauth_callbacks => 'admin/users/omniauth_callbacks'
    }
  end

  namespace :admin do

    root to: 'dashboards#index'

    get '/publications/:publication_id/download' => 'publications#download',:as => :download_file
    get '/associa_user_faculdade/:user_id' => 'users#associa_user_faculdade',:as => :associa_user_faculdade
    get '/associa_user_faculdade/:user_id/:faculdade_id' => 'users#associa_user_one_faculdade',:as => :associa_user_one_faculdade
    get '/users/:id/welcome' => 'users#welcome',:as => :welcome
    get '/indicate/:of/:to'=> 'users#indicate'
    get '/new_friend/:of/:to'=> 'users#new_friend' ,:as => :new_friend
    get '/accept_friend/:user1/:user2'=> 'users#accept_friend'
    get '/reject_friend/:user1/:user2'=> 'users#reject_friend'
    get '/notification/:user'=> 'users#eh_novo'
    post '/rating/publication/:publication_id/user/:user_id/nota/:nota' => 'publications#rating',:as => :rating

    resources :publications, :only => ['show','index']

    resources :friends

    resources :users do

      get 'my_publications', :method => :get, :as => :my_publications

      resources :publications do
        resources :comments
      end
    end

    get "/fb_share/callback" => "fb_share#callback", :method => :get , :as => :fb_callback
    get "/fb_share/auth" => "fb_share#auth", :method => :get , :as => :fb_auth

    # match '/users/:id/publications/my_publications' => 'users#my_publications', via: [:get], :as => :my_publications

  end

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
