Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'weather#temperature_page'
  post 'check_weather' => 'weather#check_weather'
end
