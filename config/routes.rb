Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  #Webhookから送られてきたリクエストを処理
  post '/callback' => 'linebot#callback'
  

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
  get '/privacy', to: 'policies#privacy'
  get '/kiyaku', to: 'policies#kiyaku'
  get '/how', to: 'policies#how'
  post 'costs/create_before', to: 'costs#create_before', as: 'create_before'
  post 'costs/create_after', to: 'costs#create_after', as: 'create_after'
  post '/costs/save_total_amount', to: 'costs#save_total_amount'

end
