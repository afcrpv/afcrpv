Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :projets, :path => '' do
    get '/projets/soumettre', to: 'projets#new', as: 'new_projet'
    resources :projets, :only => [:index, :show, :create] do
      get :merci, :on => :collection
    end
  end

  # Admin routes
  namespace :projets, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :projets
    end
  end
end
