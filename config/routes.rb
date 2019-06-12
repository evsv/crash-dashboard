Rails.application.routes.draw do
  
  get 'dashboard/dataload'

  get 'dashboard/visualisations'

  get '/help', to: 'static_pages#help'

  get '/dataload', to: 'dashboard#dataload'

  post '/data_filter', to: 'dashboard#load_socrata_data'

  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
