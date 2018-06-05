Rails.application.routes.draw do

  resources :topics do


  resources :posts, except: [:index]
  resources :sponsored_posts
  end

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  resources :questions
  resources :advertisements

  post 'users/confirm' =>'users#confirm'

  get 'about' => 'welcome#about'

  get 'welcome/contact'

  get 'welcome/faq'

  root 'welcome#index'

end
