require 'sidekiq/web'
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get :search, to: 'query#search'
    end
  end
end
