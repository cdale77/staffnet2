require "sidekiq/web"

Staffnet2::Application.routes.draw do

  authenticate :user, lambda { |u| u.role? :super_admin } do
    mount Sidekiq::Web => "/admin/sidekiq"
  end

  root  "static_pages#home"

  devise_for :users

  scope "/admin" do
    resources :users

    resources :employees do
      resources :shifts, only: :index
    end

    resources :supporters do
      resources :donations
      resources :payment_profiles
      resources :pledge_emails, only: [:new, :create]
    end

    resources :donations do
      resources :payments
    end

    resources :shifts
    resources :payments, only: :show
    resources :payment_profiles
    resources :supporter_types, except: [:show, :destroy]
    resources :shift_types, except: [:show, :destroy]
    resources :sendy_lists
    resources :deposit_batches, only: [:show, :index, :edit, :update]
    resources :paychecks, only: [:show, :edit]

    ## Dupes
    get "duplicate_records/new_batch", 
      to: "duplicate_records#new_batch", as: :new_duplicate_batch
    post "duplicate_records/new_file",
      to: "duplicate_records#new_file", as: :new_duplicate_file
    get "duplicate_records",
      to: "duplicate_records#index", as: :duplicate_records
    patch "duplicate_records/:id/resolve", 
      to: "duplicate_records#resolve", as: :resolve_duplicate_record
  end
end
