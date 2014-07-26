Staffnet2::Application.routes.draw do

  root  'static_pages#home'

  devise_for :users

  scope '/admin' do
    resources :users

    resources :employees do
      resources :shifts
    end

    # new shifts can only be made through the employee association
    resources :shifts, except: :new do
      resource :shift_type
      resource :employee
      resources :donations
    end


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

    resources :deposit_batches
  end
end
