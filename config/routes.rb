Rails.application.routes.draw do
  devise_for :users
  root to: 'journeys#index'

  # Routes for the User resource:
  get "/users", :controller => "users", :action => "index"
  get "/users/:id", :controller => "users", :action => "show"
  get "/users/edit", :controller => "users", :action => "edit"
  get "/my_likes", :controller => "likes", :action => "index"

  # Routes for the Fare resource:
  # CREATE
  get "/fares/new", :controller => "fares", :action => "new"
  post "/create_fare", :controller => "fares", :action => "create"

  # READ
  get "/fares", :controller => "fares", :action => "index"
  get "/fares/:id", :controller => "fares", :action => "show"
  get "/farecalculator", :controller => "fares", :action => "farecalc"

  # UPDATE
  get "/fares/:id/edit", :controller => "fares", :action => "edit"
  post "/update_fare/:id", :controller => "fares", :action => "update"

  # DELETE
  get "/delete_fare/:id", :controller => "fares", :action => "destroy"
  #------------------------------

  # Routes for the Seat resource:
  # CREATE
  get "/seats/new", :controller => "seats", :action => "new"
  post "/create_seat", :controller => "seats", :action => "create"

  # READ
  get "/seats", :controller => "seats", :action => "index"
  get "/seats/:id", :controller => "seats", :action => "show"

  # UPDATE
  get "/seats/:id/edit", :controller => "seats", :action => "edit"
  post "/update_seat/:id", :controller => "seats", :action => "update"

  # DELETE
  get "/delete_seat/:id", :controller => "seats", :action => "destroy"
  #------------------------------

  # Routes for the Comment resource:
  # CREATE
  get "/comments/new", :controller => "comments", :action => "new"
  post "/create_comment", :controller => "comments", :action => "create"

  # READ
  get "/comments", :controller => "comments", :action => "index"
  get "/comments/:id", :controller => "comments", :action => "show"

  # UPDATE
  get "/comments/:id/edit", :controller => "comments", :action => "edit"
  post "/update_comment/:id", :controller => "comments", :action => "update"

  # DELETE
  get "/delete_comment/:id", :controller => "comments", :action => "destroy"
  #------------------------------

  # Routes for the Journey resource:
  # CREATE
  get "/journeys/new", :controller => "journeys", :action => "new"
  post "/create_journey", :controller => "journeys", :action => "create"

  # READ
  get "/journeys", :controller => "journeys", :action => "index"
  get "/journeys/:id", :controller => "journeys", :action => "show"

  # UPDATE
  get "/journeys/:id/edit", :controller => "journeys", :action => "edit"
  post "/update_journey/:id", :controller => "journeys", :action => "update"

  # DELETE
  get "/delete_journey/:id", :controller => "journeys", :action => "destroy"
  #------------------------------

end
