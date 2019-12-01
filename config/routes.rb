Rails.application.routes.draw do
  get 'the_logz', to: 'the_logz#index'
  get 'populations', to: 'populations#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
