require 'open-uri'
require 'json'


class JourneysController < ApplicationController


  def index
    @journeys = Journey.all

    render("journeys/index.html.erb")
  end

  def show
    @journey = Journey.find(params[:id])
    @street_address = @journey.origin
      url = "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyB_nAWVr-18Oi_XoadzVHmNT2vevvJfev4&address="+@street_address.gsub(" ","+")
      parsed_data = JSON.parse(open(url).read)
      @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
      @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
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
