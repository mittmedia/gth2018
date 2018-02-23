Rails.application.routes.draw do
  resources :sms
  root 'sms#new'
  post '/message', to: 'sms#message'
end
