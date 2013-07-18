Brooch::Application.routes.draw do
  root 'root#index'
  scope '/v1' do
    post '/signin',  to: 'v1/sessions#create'
    post '/signout', to: 'v1/sessions#destroy'

    resources :users, controller: 'v1/users', only: [:create] do
      resources :posts, controller: 'v1/users/posts', only: [:index, :create]
    end
  end
end
