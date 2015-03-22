Rails.application.routes.draw do
  n = [:new, :edit]
  resources :users, except: n do
    resources :groups, except: n do
      resources :plants, except: n do
        resources :measurements, except: n
      end
    end

    resources :posts, except: n do
      resources :comments, except: n 
    end
  end

  resources :strains, except: n do
    resources :plants, except: n
  end
end
