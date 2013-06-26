# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get 'worklogs', :to => 'worklogs#index'
put 'worklogs', :to => 'worklogs#update'
# get 'worklogs/new', :to => 'worklogs#new'
resources :worklogs
