class EventsController < ApplicationController
  def index
    if params[:search]
      @events = Event.search(params[:search])
    else
      @events = Event.upcoming_events
    end
  end
  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @categories = Category.all
    @venues = Venue.all
  end

  def create
    @event = Event.new(event_params)
    @event.published = false
    @event.starts_at = DateTime.strptime(params[:event][:starts_at], '%m/%d/%Y %I:%M %p')
    @event.ends_at = DateTime.strptime(params[:event][:ends_at], '%m/%d/%Y %I:%M %p')
    @event.category_id = params[:event][:category_id].to_i
    @event.venue_id = params[:event][:venue_id].to_i
    @event.user_id = params[:event][:user_id].to_i
    if @event.save
      redirect_to root_path, flash: {success: "Your event has been created successfully"}
    else
      redirect_to root_path, flash: {error: "Please try again"}
    end
  end

  def created_events
    @events = Event.where("user_id = ?", session[:user_id])
    render 'created_events'
  end

  def publish
    @event = Event.find(params[:id])
    if @event.ticket_types.count > 0
      @event.published ^= true
      @event.save
      created_events
    else
      redirect_to created_events_path, flash: {error: "Your event should have at least 1 ticket type before publishing"}
    end
  end
  private
  def event_params
    params.require(:event).permit(:name, :extended_html_description, :hero_image_url)
  end
end