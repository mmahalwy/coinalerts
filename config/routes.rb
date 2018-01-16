Rails.application.routes.draw do
  root to: 'coinmarketcap#index'

  get 'exchange_coins', to: 'exchange_coins#index'
  get 'exchange_coins/:symbol', to: 'exchange_coins#show'

  get 'coinmarketcap/index'
  get 'coinmarketcap/:amount', to: 'coinmarketcap#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
