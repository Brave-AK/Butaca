Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get '/admin/admin_notify' => "admin/users#notify", as: "admin_notify"
  get '/admin/check_sources' => "admin/titles#check_sources", as: "admin_check_sources"
  devise_for :users, class_name: 'User'
  root to: "home#index"
  get '/welcome' => 'home#landing_page', as: :welcome
  devise_scope :user do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end
  get '/account' => 'users#show', as: :user_profile
 scope ':locale', locale: /es|en/ do
    get '/' => "home#index"

    resources :collections do
      get :follow, on: :member
    end
    resources :genre
    resources :countries
    resources :titles do
      get :follow, on: :member
    end
    resources :home
    resources :user_favorites
    resources :user_removals
    resources :user_queues
    resources :messages do
      get :report, on: :collection
    end
    get ':notification/mark_notifications_as_readed' => "user_activity_logs#mark_as_readed", as: :mark_notifications_as_readed
    get 'mark_all_notifications_as_readed' => "user_activity_logs#mark_all_as_readed", as: :mark_all_notifications_as_readed
    get 'settings' => 'users#settings', as: :user_settings
    post 'update_user' => 'users#update', as: :user_update
    post 'upload_avatar' => 'users#upload_avatar', as: :upload_avatar
  end
  get 'about' => 'home#about', as: :about
  get 'search' => 'search#search', as: :search
  get 'my_profile' => 'users#my_profile', as: :my_profile

  get 'users/:id' => 'users#show', as: :user_show
  get 'user/followed_collections' => 'users#followed_collections', as: :followed_collections
  get 'ac' => 'search#ac'
  get 'user_queues/add/:title_id' => 'user_queues#add', as: :add_to_que
  get 'user_favorites/add/:title_id' => 'user_favorites#add', as: :add_to_favorite
  get 'user_removals/add/:title_id' => 'user_removals#add', as: :add_to_removal
  # get '*path', to: redirect("/#{I18n.default_locale}/%{path}")
  get '', to: redirect("/#{I18n.default_locale}")
  # get '/:locale' => "home#index"
  post "add_a_film" => "users#add_a_film"

  get "/404", :to => "application#render_404", via: [:get, :post, :put]
end
