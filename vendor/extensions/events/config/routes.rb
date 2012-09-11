Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :events, path: 'agenda' do
    resources :events, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :events, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :events, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

  namespace :categories, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :categories, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
