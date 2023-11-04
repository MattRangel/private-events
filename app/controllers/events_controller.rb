class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
    return redirect_to root_path unless current_user.eql?(@event.creator)
  end

  def update
    @event = Event.find(params[:id])
    return redirect_to root_path unless current_user.eql?(@event.creator)
    @event.attributes = event_params
    if @event.save
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.delete
    redirect_to root_path
  end

  private
  def event_params
    params.require(:event).permit(:name, :location, :time)
  end
end
