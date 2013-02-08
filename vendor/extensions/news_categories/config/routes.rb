Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :news_categories do
    resources :news_categories, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :news_categories, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :news_categories, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
