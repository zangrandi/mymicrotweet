Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}

  devise_scope :user do
	  authenticated :user do
	    root 'posts#feed', as: :user_feed
	  end

	  unauthenticated do
	    root 'pages#home', as: :root
	  end
	end

	resources :posts, only: [:create, :destroy] do
		collection do
			get :feed
			get :public_feed
		end
	end

	resources :users, only: [:index] do
		member do
			post :follow
			post :unfollow
			get :notifications
		end
		collection do
			post :search
		end
	end

	resources :users, only: [:show], path: '/'
end
