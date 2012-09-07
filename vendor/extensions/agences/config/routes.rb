Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :agences do
    resources :agences, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :agences, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :agences, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
