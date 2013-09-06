Paycheck::Application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  get '/about' => 'static_pages#about'
  get '/submit' => 'static_pages#submit'
  get '/privacy' => 'static_pages#privacy'
  get '/facebook' => 'static_pages#facebook_channel'

  resources :categories, except: :index, :path => '/' do
    resources :products, except: :index
  end
end
