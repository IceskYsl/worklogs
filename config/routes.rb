# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get 'worklogs', :to => 'worklogs#index'
get 'worklogs/my', :to => 'worklogs#my'
put 'worklogs', :to => 'worklogs#update'


resources :worklogs
