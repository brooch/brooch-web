Brooch::Application.routes.draw do
  scope '/v1' do
    resources :users, controller: 'v1/users'
  end
end
