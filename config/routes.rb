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

  resource :policies, only: [] do
    collection do
      get :privacy
      get :kiyaku
      get :how
    end
  end

  resource :costs, only: [] do
    collection do
      post :create_before
      post :create_after
      post :save_per_person_cost
    end
  end

  root 'tops#top'
  get '/wakeup', to: 'tops#wakeup'
end
