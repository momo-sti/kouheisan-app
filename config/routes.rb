Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :tops, only: [:new, :reset_session] do
    post :reset_session, on: :collection
  end
  resources :calculations do
    get :result, on: :collection
    post :result, on: :collection
    post :datasave, on: :collection
  end
  resources :gasolines do
    post :calculate, on: :collection
    get :calculate, on: :collection
  end


  resources :highways do
    collection do
      get :create_highway
      post :save_highway_info
      get :highway
      get :reset_cost
      get :reset_and_redirect
    end

  end

  resources :extras


  root 'tops#top'
  get '/wakeup', to: 'tops#wakeup'
end
