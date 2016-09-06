Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  
  resources :templates

  root 'main#index'
  get 'lists/pages' => 'lists#index'
  get "/lists/:email" => "lists#single",
    :constraints => { :email => /.+@.+\..*/ }
  get "/send/:email" => "send#index",
    :constraints => { :email => /.+@.+\..*/ }
  match "/send/:email", to: 'send#create', via: [:post],
    :constraints => { :email => /.+@.+\..*/ }
  match "/templates/:id/sendd", to: 'templates#sendd', via: [:get, :post]
end
