class FaresController < ApplicationController
  def farecalc

    render("fares/farecalculator.html.erb")
  end

  def index
    @fares = Fare.all

    render("fares/index.html.erb")
  end

  def show
    @fare = Fare.find(params[:id])
    @origin = @fare.origin
    @destination = @fare.destination
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

    # UberPOOL
    uberpool_estimate = uber.select { |x| x[:display_name] == 'uberPOOL' }.map { |u| u[:estimate] }
    @uberpool_estimate = uberpool_estimate.to_s.gsub(/\[|\]/,"").gsub('"',"")

    # UberX
    uberx_estimate = uber.select { |x| x[:display_name] == 'uberX' }.map { |u| u[:estimate] }
    @uberx_estimate = uberx_estimate.to_s.gsub(/\[|\]/,"").gsub('"',"")

    # UberXL
    uberxl_estimate = uber.select { |x| x[:display_name] == 'uberXL' }.map { |u| u[:estimate] }
    @uberxl_estimate = uberxl_estimate.to_s.gsub(/\[|\]/,"").gsub('"',"")

    # UberBLACK
    uberblack_estimate = uber.select { |x| x[:display_name] == 'UberBLACK' }.map { |u| u[:estimate] }
    @uberblack_estimate = uberblack_estimate.to_s.gsub(/\[|\]/,"").gsub('"',"")

    # UberSELECT
    uberselect_estimate = uber.select { |x| x[:display_name] == 'UberSELECT' }.map { |u| u[:estimate] }
    @uberselect_estimate = uberselect_estimate.to_s.gsub(/\[|\]/,"").gsub('"',"")

    render("fares/show.html.erb")
  end

  def new
    @fare = Fare.new

    render("fares/new.html.erb")
  end

  def create
    @fare = Fare.new

    @fare.origin = params[:from]
    @fare.destination = params[:to]

    save_status = @fare.save

    if save_status == true
      redirect_to("/fares/#{@fare.id}", :notice => "Congratulations - below are the current Uber fares for your journey.")
    else
      render("fares/new.html.erb")
    end
  end

  def edit
    @fare = Fare.find(params[:id])

    render("fares/edit.html.erb")
  end

  def update
    @fare = Fare.find(params[:id])

    @fare.origin = params[:origin]
    @fare.destination = params[:destination]

    save_status = @fare.save

    if save_status == true
      redirect_to("/fares/#{@fare.id}", :notice => "Fare estimated successfully.")
    else
      render("fares/edit.html.erb")
    end
  end

  def destroy
    @fare = Fare.find(params[:id])

    @fare.destroy

    if URI(request.referer).path == "/fares/#{@fare.id}"
      redirect_to("/", :notice => "Fare deleted.")
    else
      redirect_to(:back, :notice => "Fare deleted.")
    end
  end
end
