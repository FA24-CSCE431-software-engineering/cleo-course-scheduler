class TracksController < ApplicationController
  before_action :set_track, only: [:edit, :update, :destroy]

  def confirm_destroy
    @track = Track.find(params[:id])
  end

  def destroy
    @track.destroy
    redirect_to tracks_path, notice: "Track successfully deleted."
  end

  def edit
  end

  def index
    @tracks = Track.all
    @track = Track.new
  end

  def new
    @track = Track.new
  end

  def show
  end

  def update
    if @track.update(track_params)
      redirect_to tracks_path, notice: "Track successfully updated."
    else
      @tracks = Track.all
      render :index
    end
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to tracks_path, notice: "Track successfully created."
    else
      @tracks = Track.all
      render :index
    end
  end

  # callbacks for common setups
  def set_track
    @track = Track.find(params[:id])
  end

  def track_params
    params.require(:track).permit(:tname)
  end
end
