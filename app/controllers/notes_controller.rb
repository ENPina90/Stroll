class NotesController < ApplicationController
  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    authorize @note
    @note.user = current_user
    @note.location_id = params[:location_id]
    if @note.save
      flash[:notice] = "Note saved"
      redirect_to(location_path(Location.find(params[:location_id])))
    else
      flash[:alert] = "Note not saved, at least 10 characters"
      redirect_to(location_path(Location.find(params[:location_id])))
    end
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end
end
