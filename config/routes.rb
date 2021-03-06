GmaMonitoramento::Application.routes.draw do
  devise_for:users, :path_prefix => 'd'

  resources :users
  get "admin/index"
  get "home/meus_monitoramentos"
  get "busca/index"
  get "estatistica/index"
  get "estatistica/show"

  resources :monitoramentos do
    member do
      get "remove_ocorrencia"
    end
  end

  scope "admin" do
    resources :ocorrencias
    resources :cameras
    resources :visores
    resources :configurations
  end

  #, skip: :registrations do
  #  # Desabilita o recurso onde o proprio usuario pode apagar sua conta.
  #  # Dessa forma garante que o usuario não coseguira apagar a propria conta.
  #  resource :registration,
  #           only: [:new, :create, :edit, :update],
  #           path: 'users',
  #           path_names: { new: 'sign_up' },
  #           controller: 'devise/registrations',
  #           as: :user_registration do
  #    get :cancel
  #  end
  #end

  #namespace :admin do
    # Directs /admin/products/* to Admin::ProductsController
    # (app/controllers/admin/products_controller.rb)
  #  resources :users
  #end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  #route condicional quando for admin deve levar a pagina do admin  (request.env["warden"].user ))
  root :to => "admin#index", :constraints => lambda{|request| request.session[:user_admin] }
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
