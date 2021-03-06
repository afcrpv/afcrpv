Refinery::Core::Engine.routes.prepend do
  get '/documents/mots_cles/:mot_cle', to: "documents/documents#index", as: :mot_cle
  get '/documents/categories', to: "documents/categories#index", as: :categories
  get '/documents/tags', to: 'documents/documents#tags', as: :document_tags
  get '/departements', to: 'departements#index', as: :departements
  get '/tags', to: 'tags#index', as: :tags
  get '/crpvs/paris', :to => 'crpvs/crpvs#paris', :as => :paris
  get '/crpvs/search', :to => 'crpvs/crpvs#search', :as => :crpvs_search
  get '/enquetes/:id', to: 'enquetes#show', as: :enquete
  get '/medicaments', to: 'medicaments#index', as: :medicaments
  get '/evenements', to: 'evenements#index', as: :evenements
  get '/indications', to: 'indications#index', as: :indications
end
Afcrpv::Application.routes.draw do
  resources :indications
  resources :medicaments do
    collection do
      post :import
      get :liste
    end
  end
  resources :evenements do
    collection { get :liste}
  end
  resources :dossiers
  resources :enquetes do
    collection { post :add_medicaments }
    collection { post :add_evenements }
  end

  # This line mounts Refinery's routes at the root of your application.
  # This means, any requests to the root URL of your application will go to Refinery::PagesController#home.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Refinery relies on it being the default of "refinery"
  mount Refinery::Core::Engine, :at => '/'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
