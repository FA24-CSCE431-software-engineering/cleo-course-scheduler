
# spec/requests/admin/tracks_spec.rb
require 'rails_helper'

RSpec.describe "Admin::Tracks", type: :request do
  let!(:track) { Track.create!(tname: "Systems") } # Directly creating a track

  describe "GET /admin/tracks" do
    it "returns http success" do
      get admin_tracks_path
      expect(response).to have_http_status(:success)
      expect(assigns(:tracks)).to include(track)
    end
  end

  describe "GET /admin/tracks/:id" do
    it "returns http success" do
      get admin_track_path(track)
      expect(response).to have_http_status(:success)
      #expect(assigns(:track)).to eq(track)
    end
  end

  describe "POST /admin/tracks" do
    it "creates a new track and redirects" do
      post admin_tracks_path, params: { track: { tname: "New Track" } }
      expect(response).to redirect_to(admin_tracks_path)
      follow_redirect!
      expect(response.body).to include("Track successfully created.")
      expect(Track.last.tname).to eq("New Track") # Check if the new track is created
    end

    it "re-renders the index template on failure" do
      post admin_tracks_path, params: { track: { tname: "" } } # Invalid params
      expect(response).to render_template(:index)
      expect(assigns(:track).errors.full_messages).to include("Tname can't be blank")
    end
  end

  describe "PATCH /admin/tracks/:id" do
    it "updates the track and redirects" do
      patch admin_track_path(track), params: { track: { tname: "Updated Track" } }
      expect(response).to redirect_to(admin_tracks_path)
      follow_redirect!
      expect(response.body).to include("Track successfully updated.")
      expect(track.reload.tname).to eq("Updated Track")
    end

    it "re-renders the index template on failure" do
      patch admin_track_path(track), params: { track: { tname: "" } } # Invalid params
      expect(response).to render_template(:index)
      expect(assigns(:track).errors.full_messages).to include("Tname can't be blank")
    end
  end

  describe "DELETE /admin/tracks/:id" do
    it "deletes the track and redirects" do
      delete admin_track_path(track)
      expect(response).to redirect_to(admin_tracks_path)
      follow_redirect!
      expect(response.body).to include("Track successfully deleted.")
      expect { track.reload }.to raise_error(ActiveRecord::RecordNotFound) # Check if it is deleted
    end
  end
end
