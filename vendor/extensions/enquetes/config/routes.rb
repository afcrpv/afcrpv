Refinery::Core::Engine.routes.append do

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
