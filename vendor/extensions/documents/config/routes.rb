Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :documents, :path => '' do
    resources :documents, except: [:destroy], path_names: {new: "nouveau", edit: "modifier"}
  end

  # Admin routes
  namespace :documents, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :documents, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end