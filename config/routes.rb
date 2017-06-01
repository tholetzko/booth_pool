Rails.application.routes.draw do
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

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'journeys#index'
end
