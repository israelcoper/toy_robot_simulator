Rails.application.routes.draw do
  post 'report', to: 'home#report'

  root to: 'home#index'
end
