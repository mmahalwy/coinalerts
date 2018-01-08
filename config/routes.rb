Rails.application.routes.draw do
  get 'exchange_coins', to: 'exchange_coins#index'

  root to: 'coinmarketcap#index'

  get 'coinmarketcap/index'
  get 'coinmarketcap/:amount', to: 'coinmarketcap#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
