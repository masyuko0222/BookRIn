# frozen_string_literal: true

class ReadingClubs::OverviewController < ApplicationController
  before_action :set_reading_club, only: :show

  def show; end

  private

  def set_reading_club
    @reading_club = ReadingClub.find(params[:reading_club_id])
  end
end
