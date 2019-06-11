Rails.application.routes.draw do
  
  get 'dashboard/dataload'

  get 'dashboard/visualisations'

  get '/help', to: 'static_pages#help'

  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
