Rails.application.routes.draw do
  resources :sms
  root 'app#show'
  post '/message', to: 'sms#message'
end
