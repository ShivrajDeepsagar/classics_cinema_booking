Rails.application.routes.draw do

  root 'bookings#home'

  get '/booknow', to: 'bookings#book_now'

  get '/buyticket', to: 'bookings#buy_ticket'
  post '/buyticket', to: 'bookings#buy_ticket_details'

  get '/selectseats', to: 'bookings#select_seats'
  post '/selectseats', to: 'bookings#seats_details'

  get '/payment', to: 'bookings#payment'
  post '/payment', to: 'bookings#payment_details'

  get '/applycoupon', to: 'bookings#apply_coupon'
  post '/applycoupon', to: 'bookings#coupon_validation'


  get '/signup', to: 'users#new'
  post '/signup',   to: 'users#create'

  get '/bookings', to: 'users#booking'
  delete '/bookings', to: 'users#cancle_ticket'


  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  get    '/newmovie', to: 'admin#add_movies'
  post   '/newmovie', to: 'admin#create_movies'

  get    '/addtheater', to: 'admin#add_theater'
  post   '/addtheater', to: 'admin#create_theater'

  get    '/createscreening', to: 'admin#create_screening'
  post   '/createscreening', to: 'admin#show_screening'

end