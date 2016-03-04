require "sidekiq/web"

Staffnet2::Application.routes.draw do

  ActiveAdmin.routes(self)
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
    resources :payments, only: [:show, :destroy]
    resources :payment_profiles
    resources :supporter_types, except: [:show, :destroy]
    resources :shift_types, except: [:show, :destroy]
    resources :sendy_lists
    resources :deposit_batches, only: [:show, :index, :edit, :update]
    get "deposit_batches/:id/process_batch",
      to: "deposit_batches#process_batch", as: :process_batch
    resources :paychecks, only: [:show, :edit, :update]
    resources :payrolls, only: [:show, :index, :create]
    resources :data_reports, only: [:new, :create, :index]
    get "/data_reports/:id/downloadable_file",
      to: "data_reports#downloadable_file", as: :data_report_downloadable_file


    ## Dupes
    resources :duplicate_records, only: [:update, :destroy]
    # the edit action just pulls the first record of the db
    get "duplicate_records/edit",
        to: "duplicate_records#edit",
        as: :edit_duplicate_record
    get "duplicate_records/new_batch",
      to: "duplicate_records#new_batch", as: :new_duplicate_batch
    post "duplicate_records/new_file",
      to: "duplicate_records#new_file", as: :new_duplicate_file
  end
end

