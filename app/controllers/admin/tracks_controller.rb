# frozen_string_literal: true

module Admin
  class TracksController < ApplicationController
    include AdminAuthentication

    skip_before_action :authenticate_student_login! if Rails.env.test?
    before_action :set_track, only: %i[update destroy]

    def show
      # @track is set via callback below
      @track = set_track
    end

    def index
      @tracks = Track.all
      @track = params[:id] ? Track.find(params[:id]) : Track.new
    end

    def create
      @track = Track.new(track_params)
      if @track.save
        redirect_to admin_tracks_path, notice: 'Track successfully created.'
      else
        @tracks = Track.all
        render :index
      end
    end

    def edit; end

    def update
      if @track.update(track_params)
        redirect_to admin_tracks_path, notice: 'Track successfully updated.'
      else
        @tracks = Track.all
        render :index
      end
    end

    def destroy
      @track.destroy
      redirect_to admin_tracks_path, notice: 'Track successfully deleted.'
    end

    private

    def set_track
      @track = Track.find(params[:id])
    end

    def track_params
      params.require(:track).permit(:tname)
    end
  end
end
