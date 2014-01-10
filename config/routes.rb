Staffnet2::Application.routes.draw do

  root  'static_pages#home'

  devise_for :users#, :controllers => { :registrations => 'users/registrations' }
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
      #resources :tasks
    end

    resources :clients

    resources :supporters do
      resources :donations
    end

    resources :donations do
      resources :payments
    end

    resources :payments

    resources :supporter_types, except: [ :show, :destroy ]
    resources :shift_types, except: [ :show, :destroy ]

    #resources :clients do
    #  resources :projects
    #end

    #resources :projects do
    #  resource :client
    #  resources :tasks
    #end

    #resources :tasks do
    #  resource :project
    #  resource :shift
    #end

    #resources :task_types

  end


end
