Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :crpvs do
    resources :crpvs, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :crpvs, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :crpvs, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
