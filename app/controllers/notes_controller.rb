class NotesController < ApplicationController
  def new
    @note = Note.new
  end

  def create
    @note = Note.new
    authorize @note
    @note.user = current_user
    @note.location = Location.find(params[:note][:location_id])
    if @note.save
      flash[:notice] = "Note saved"
      redirect_to(location_path(@note.location))
    else
      flash[:alert] = "Note not saved"
      redirect_to(location_path(@note.location))
    end
  end
end
