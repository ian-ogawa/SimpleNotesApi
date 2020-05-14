class Api::V1::NotesController < Api::ApplicationController

  before_action :set_note, only: [:show, :update, :destroy]

  def index
    notes = Note.all
    # json_response({ notes: notes }, :unprocessable_entity)
    json_response_with_serializer(notes, { adapter: :json, root: "notes" })
  end

  def show
    json_response_with_serializer(@note, @note.nil? ? :not_found : :ok, { adapter: :json, root: "notes" })
  end

  def create
    note = Note.new(notes_params)

    note.save ? json_response_with_serializer(note, :created, { adapter: :json, root: "notes" }) : json_response({ note: {} }, :unprocessable_entity, note.errors)
  end

  def update
    if @note.present?
      @note.update(notes_params) ? json_response_with_serializer(@note, { adapter: :json, root: "notes" }) : json_response({ note: {} }, :unprocessable_entity, @note.errors)
    else
      json_response({ note: {} }, :not_found)
    end
  end

  def destroy
    if @note.present?
      @note.destroy ? json_response({ note: {} }, :ok) : json_response({ note: {} }, :unprocessable_entity, "Failed please try again later")
    else
      json_response({ note: {} }, :not_found)
    end
  end

  private

  def notes_params
    params.require(:notes).permit(:id, :title, :content, label_ids: [])
  end

  def set_note
    @note = Note.find_by(id: params[:id])
  end

end