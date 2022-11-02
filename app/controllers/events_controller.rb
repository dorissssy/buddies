class EventsController < ApplicationController
  # before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    @all_tags = Event.all_tags

    if params[:commit] == "Refresh"
      reset_session
    end

    @tags_to_show = session[:tags_to_show] || @all_tags

    if (!params[:tags] && !params[:sort]) && (session[:sort_key] || session[:tags_to_show])
      redirect_to events_path(:sort => session[:sort_key],
                              :tags => Hash[@tags_to_show.map {|x| [x, 1]}])
    end

    if params[:tags]
      @tags_to_show = params[:tags].keys
    else
      @tags_to_show = Event.all_tags
    end
    session[:tags_to_show] = @tags_to_show

    @sort_key = params[:sort] || ''

    session[:sort_key] = @sort_key

    @events = Event.with_tags_sort(@tags_to_show, @sort_key)

  end

  # GET /events/1 or /events/1.json
  def show
    id = params[:id]
    @event = Event.find(id)
  end

  # GET /events/new
  def new
    # @event = Event.new
  end

  # POST /events or /events.json
  def create
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @event = Event.new(event_params)
      @event.user = current_user
      @event.save!
      flash[:notice] = "#{@event.event_name} was successfully created."
      redirect_to events_path
      end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    @event = Event.find(params[:id])
    if @event.user == current_user
      @event.update(event_params)
      flash[:notice] = "Event #{@event.event_name} was successfully updated."
    else
      flash[:warning] = "Event #{@event.event_name} couldn't be edited by you."
    end
    redirect_to event_path()
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event = Event.find(params[:id])
    if @event.user == current_user
      @event.destroy
      flash[:notice] = "Event #{@event.event_name} was successfully deleted."
    else
      flash[:warning] = "Event #{@event.event_name} couldn't be deleted by you."
    end
    redirect_to events_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:event_name,:tag,:address,:description, :start_time, :end_time,
                                    :price, :available_spots, :occupied_spots, :price)
    end
end
