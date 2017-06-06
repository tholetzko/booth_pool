class JourneysController < ApplicationController
  require 'open-uri'
  require 'json'

  def index
    @q = Journey.ransack(params[:q])
    @journeys = @q.result
    render("journeys/index.html.erb")
  end

  def show
    @journeys = Journey.all
    @journey = Journey.find(params[:id])
    @origin = @journey.origin
    @destination = @journey.destination

    # Parse geocoordinates
    url ="https://maps.googleapis.com/maps/api/directions/json?key=AIzaSyB3eG1Vt6y54OrKrHgpJnZb66QxQvy0kfM&origin="+@origin+"&destination="+@destination+"&sensor=false".gsub(" ","+")
    parsed_data = JSON.parse(open(url).read)
    @start_lat = parsed_data["routes"][0]["legs"][0]["start_location"]["lat"]
    @start_lng = parsed_data["routes"][0]["legs"][0]["start_location"]["lng"]
    @end_lat = parsed_data["routes"][0]["legs"][0]["end_location"]["lat"]
    @end_lng = parsed_data["routes"][0]["legs"][0]["end_location"]["lng"]

    # Uber API
    client = Uber::Client.new do |config|
      config.server_token  = "lFNFQ-VIhAXqiwJNY8YJ9374hP_0MUeZndHSNs3k"
      config.client_id     = "2oVqH3_uKKBif3xXNrXY-EpG5hLjguJi"
      config.client_secret = "WsFaZ_JEZei9SEbgh0qEchIiSMTvR0ZLbgM-xmrQ"
      config.sandbox       = false
    end

    uber = client.price_estimations(start_latitude: @start_lat, start_longitude: @start_lng,
    end_latitude: @end_lat, end_longitude: @end_lng)

    uber_duration = uber.select { |x| x[:display_name] == 'uberX' }.map { |u| u[:duration] }
    @uber_duration = uber_duration.to_s.gsub(/\[|\]/,"").gsub('"',"")

    uber_distance = uber.select { |x| x[:display_name] == 'uberX' }.map { |u| u[:distance] }
    @uber_distance = uber_distance.to_s.gsub(/\[|\]/,"").gsub('"',"")

    # Uber X
    uberx_estimate = uber.select { |x| x[:display_name] == 'uberX' }.map { |u| u[:estimate] }
    @uberx_estimate = uberx_estimate.to_s.gsub(/\[|\]/,"").gsub('"',"")

    # UberPOOL
    uberpool_estimate = uber.select { |x| x[:display_name] == 'uberPOOL' }.map { |u| u[:estimate] }
    @uberpool_estimate = uberpool_estimate.to_s.gsub(/\[|\]/,"").gsub('"',"")

    # Lyft API - **not working**
    # client = Lyft::Client.new(
    # client_id: '-PoccgdT6obM',
    # client_secret: 'twIt8_zgBpB9mI3o_AVLFPR3gSgtbJUs',
    # debug_output: STDOUT,
    # use_sandbox: true
    # )
    #
    # # Public token
    # client.oauth.retrieve_access_token
    #
    # # When using oauth.
    # client.oauth.retrieve_access_token authorization_code: 'auth_code'
    #
    # client.availability.cost access_token: 'eDML1DNeun3HevxzN3xICxpWoYxwlAAzUC+wqkqxjhyFr3JekQ1XihIofv0hSduaCry3nsESGT79Te+8Yiayxv5XQqF8MRHckQJoIq84iuy+8w/RTKDxqLw='
    # start_lat: 37.7772,
    # start_lng: -122.4233,
    # end_lat: 37.7972,
    # end_lng: -122.4533

    render("journeys/show.html.erb")
  end

  def new
    @journey = Journey.new

    render("journeys/new.html.erb")
  end

  def create
    @journey = Journey.new

    @journey.origin = params[:origin]
    @journey.destination = params[:destination]
    @journey.capacity = params[:capacity]
    @journey.date = params[:date]
    @journey.price = params[:price]
    @journey.organizer_id = params[:organizer_id]


    save_status = @journey.save

    if save_status == true
      redirect_to("/journeys/#{@journey.id}", :notice => "Journey created successfully.")
    else
      render("journeys/new.html.erb")
    end
  end

  def edit
    @journey = Journey.find(params[:id])

    render("journeys/edit.html.erb")
  end

  def update
    @journey = Journey.find(params[:id])

    @journey.origin = params[:origin]
    @journey.destination = params[:destination]
    @journey.capacity = params[:capacity]
    @journey.date = params[:date]
    @journey.price = params[:price]
    @journey.organizer_id = params[:organizer_id]

    save_status = @journey.save

    if save_status == true
      redirect_to("/journeys/#{@journey.id}", :notice => "Journey updated successfully.")
    else
      render("journeys/edit.html.erb")
    end
  end

  def destroy
    @journey = Journey.find(params[:id])

    @journey.destroy

    if URI(request.referer).path == "/journeys/#{@journey.id}"
      redirect_to("/", :notice => "Journey deleted.")
    else
      redirect_to("/journeys", :notice => "Journey deleted.")
    end
  end
end
