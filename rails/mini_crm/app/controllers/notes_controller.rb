class NotesController < ApplicationController
  # Ensure user is signed in, except for viewing note list or individual note
  before_action :authenticate_user!, except: %i[index show]

  # Load the note for actions that need it
  before_action :set_note, only: %i[show edit update destroy]

  # Ensure only the owner of the note can edit or delete it
  before_action :authorize_note_owner!, only: %i[edit update destroy]

  # GET /notes
  # Show all notes (optional feature, could be scoped later)
  def index
    @notes = Note.all
  end

  # GET /notes/1
  # Show a single note
  def show
  end

  # GET /notes/new
  # Render new note form, preassigning contact_id
  def new
    @note = Note.new(contact_id: params[:contact_id])
  end

  # GET /notes/1/edit
  # Edit form for a note
  def edit
  end

  # POST /notes
  # Create and save a new note
  def create
    @note = Note.new(note_params)
    @note.user = current_user # associate note with the signed-in user

    if @note.save
      # Update the related contact’s last_contacted_at timestamp
      contact = @note.contact
      contact.update(last_contacted_at: Time.current)

      redirect_to contact_path(contact), notice: "Note was successfully created."
    else
      # Reload all notes if validation fails to re-render contact detail view
      @contact = @note.contact
      @notes = @contact.notes.order(created_at: :desc)
      render "contacts/show", status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  # Update an existing note
  def update
    if @note.update(note_params)
      redirect_to contact_path(@note.contact), notice: "Note was successfully updated."
    else
      # Reload notes on validation failure to preserve contact view state
      @contact = @note.contact
      @notes = @contact.notes.order(created_at: :desc)
      render "contacts/show", status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  # Delete a note
  def destroy
    contact = @note.contact
    @note.destroy!
    redirect_to contact_path(contact), notice: "Note was successfully deleted."
  end

  private

    # Find note by ID
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow note owners to edit or delete
    def authorize_note_owner!
      unless @note.user == current_user
        redirect_to contact_path(@note.contact), alert: "You are not allowed to perform this action."
      end
    end

    # Strong parameters: only allow expected attributes
    def note_params
      params.require(:note).permit(:content, :contact_id)
    end
end
