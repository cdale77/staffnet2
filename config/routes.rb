Staffnet2::Application.routes.draw do

  root  "static_pages#home"

  devise_for :users

  scope "/admin" do
    resources :users

    resources :employees do
      resources :shifts
    end

    resources :shifts


    resources :supporters do
      resources :donations
      resources :payment_profiles
      resources :pledge_emails, only: [:new, :create]
    end

    resources :donations do
      resources :payments
    end

    resources :payment_profiles

    resources :supporter_types, except: [:show, :destroy]
    resources :shift_types, except: [:show, :destroy]

    resources :sendy_lists

    resources :deposit_batches, only: [:show, :index, :edit, :update]
  end
end
