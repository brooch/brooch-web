Brooch::Application.routes.draw do
  scope '/v1' do
    resources :users, controller: 'v1/users', only: [:create]
    post '/signin',  to: 'v1/sessions#create'
    post '/signout', to: 'v1/sessions#destroy'
  end
end
