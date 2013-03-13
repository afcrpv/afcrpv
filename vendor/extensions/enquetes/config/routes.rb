Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :enquetes do
    resources :enquetes, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :enquetes, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :enquetes, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
