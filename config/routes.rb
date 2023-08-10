Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  #Webhookから送られてきたリクエストを処理
  post '/callback' => 'linebot#callback'
  
  resources :favorite_locations

  resources :tops, only: [:new, :reset_session, :focus] do
    collection do
      post :reset_session
      get :favorites
    end
  end

  resources :gasolines, only: [:new, :create]

  resources :highways, only: [:index, :create] do
    collection do
      post :save_highway_info
      get :highway
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

  resource :costs, only: [:create] do
    collection do
      post :save_per_person_cost
    end
  end

  root 'tops#top'
  get '/wakeup', to: 'tops#wakeup'
  get '/search_favorite_location', to: 'tops#search_favorite_location'

  #エラーページ
  get '/404"', to: 'application#render_not_found'
  get '/500', to: 'application#render_internal_server_error'
end
