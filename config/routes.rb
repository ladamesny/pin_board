Rails.application.routes.draw do
  devise_for :users
  resources :pins do
    member do
      put "like", to: "pins#upvote"
    end
    resources :comments, except: [:index, :show] do
      member do
        put "like", to: "comments#upvote"
      end
    end
  end

  root 'pins#index'
end
