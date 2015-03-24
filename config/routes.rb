Rails.application.routes.draw do
  post 'signup', to: 'users#create'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'

  n = [:new, :edit]
  resources :users, except: n
  resources :groups, except: n
  resources :plants, except: n do
    resources :measurements, except: n
  end
  resources :strains, except: n

  resources :posts, except: n do
    resources :comments, except: n 
  end
end
