# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :set_note, only: %i[destroy]

  def new; end

  def show; end

  def edit; end

  def update; end

  def destroy
    @note.destroy
    flash.now.notice = 'ノートを削除しました'
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end
end
