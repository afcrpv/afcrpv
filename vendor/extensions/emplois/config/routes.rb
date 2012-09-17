Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :emplois do
    resources :emplois, :path => '', :only => [:index, :show]
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
