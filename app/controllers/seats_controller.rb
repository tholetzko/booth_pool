class SeatsController < ApplicationController
  def index
    @seats = Seat.all

    render("seats/index.html.erb")
  end

  def show
    @seat = Seat.find(params[:id])

    render("seats/show.html.erb")
  end

  def new
    @seat = Seat.new

    render("seats/new.html.erb")
  end

  def create
    @seat = Seat.new
    @seat.journey_id = params[:journey_id]
    @seat.user_id = params[:user_id]

    if (Seat.where(:journey_id => @seat.journey_id).count + 1) > Journey.find_by(:id => @seat.journey_id).capacity

      redirect_to("/journeys", :alert => "No capacity.")

    else

      save_status = @seat.save

      if save_status == true
        redirect_to("/journeys/#{Journey.find_by(:id => @seat.journey_id).id}", :notice => "Seat created successfully.")
      else
        render("seats/new.html.erb")
      end
    end
  end

  def edit
    @seat = Seat.find(params[:id])

    render("seats/edit.html.erb")
  end

  def update
    @seat = Seat.find(params[:id])

    @seat.journey_id = params[:journey_id]
    @seat.user_id = params[:user_id]

    save_status = @seat.save

    if save_status == true
      redirect_to("/seats/#{@seat.id}", :notice => "Seat updated successfully.")
    else
      render("seats/edit.html.erb")
    end
  end

  def destroy
    @seat = Seat.find(params[:id])

    @seat.destroy

    if URI(request.referer).path == "/seats/#{@seat.id}"
      redirect_to("/", :notice => "Seat deleted.")
    else
      redirect_to(:back, :notice => "Seat deleted.")
    end
  end
end
