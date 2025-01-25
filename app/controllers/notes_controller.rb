# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :set_note, only: %i[edit update destroy]

  def new; end

  def edit; end

  def update
    if @note.update(note_params)
      flash.now.notice = 'ノートを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy
    flash.now.notice = 'ノートを削除しました'
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:held_on, :title, :content)
  end
end
