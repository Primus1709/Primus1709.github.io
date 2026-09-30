Rails.application.routes.draw do
  root "pages#home"

  # /projects and /projects/:slug
  resources :projects, only: %i[index show]

  # The contact form posts here
  resources :messages, only: :create

  # Everything under /admin is password-protected (see Admin::BaseController)
  namespace :admin do
    root "projects#index"
    resources :projects, except: :show
    resources :messages, only: %i[index show destroy]
  end

  # Health check for hosting platforms
  get "up" => "rails/health#show", as: :rails_health_check
end
