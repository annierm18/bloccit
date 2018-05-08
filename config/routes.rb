Rails.application.routes.draw do



  resources :posts

  resources :advertisements

  get 'about' => 'welcome#about'

  get 'welcome/contact'

  get 'welcome/faq'

  root 'welcome#index'

end
