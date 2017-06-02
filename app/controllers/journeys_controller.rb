require 'open-uri'
require 'json'


class JourneysController < ApplicationController


  def index
    @journeys = Journey.all

    render("journeys/index.html.erb")
  end

  def show
    @journey = Journey.find(params[:id])
    @journey_origin = @journey.origin
    @journey_destination = @journey.destination


    url ="https://maps.googleapis.com/maps/api/directions/json?key=AIzaSyB_nAWVr-18Oi_XoadzVHmNT2vevvJfev4&origin="+@journey_origin+"&destination="+@journey_destination+"&sensor=false".gsub(" ","+")

    parsed_data = JSON.parse(open(url).read)

    @start = parsed_data["routes"][0]["legs"][0]["start_address"]
    @end = parsed_data["routes"][0]["legs"][0]["end_address"]
    # @latitude = parsed_data["routes"]["legs"]["distance"]




    @client = Uber::Client.new do |config|
      config.server_token  = "lFNFQ-VIhAXqiwJNY8YJ9374hP_0MUeZndHSNs3k"
      config.client_id     = "2oVqH3_uKKBif3xXNrXY-EpG5hLjguJi"
      config.client_secret = "WsFaZ_JEZei9SEbgh0qEchIiSMTvR0ZLbgM-xmrQ"
      config.sandbox       = true
    end

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
