Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :emplois, :path => '' do
    get '/emplois/deposer', to: 'emplois#new', as: 'new_emploi'
    resources :emplois, :only => [:index, :show, :create] do
      get :merci, on: :collection
    end
  end

  # Admin routes
  namespace :emplois, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :emplois, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
