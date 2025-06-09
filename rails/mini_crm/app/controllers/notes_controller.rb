# /app/controllers/notes_controller.rb

class NotesController < ApplicationController
  # Ensure user is signed in for all actions
  before_action :authenticate_user!

  # Load the note for actions that need it
  before_action :set_note, only: %i[show edit update destroy]

  # Ensure only the owner of the note can edit or delete it
  before_action :authorize_note_owner!, only: %i[edit update destroy show]

  # GET /notes
  # Show all notes (optional feature, could be scoped later)
  def index
    @notes = current_user.notes.includes(:contact).order(created_at: :desc)
  end

  # GET /notes/1
  # Show a single note
  def show
  end

  # GET /notes/new
  # Render new note form, optionally preassigning contact_id
  def new
    if params[:contact_id].present?
      @contact = current_user.contacts.find(params[:contact_id])
      @note = @contact.notes.build
    else
      @note = Note.new
      @contacts = current_user.contacts.order(:name)
    end
  end

  # GET /notes/1/edit
  # Edit form for a note
  def edit
  end

  # POST /notes
  # Create and save a new note
  def create
    if params[:contact_id].present?
      # Creating note from contact page
      @contact = current_user.contacts.find(params[:contact_id])
      @note = @contact.notes.build(note_params)
      @note.user = current_user
    
      if @note.save
        redirect_to contact_path(@contact), notice: "Note was successfully created."
      else
        @notes = @contact.notes.order(created_at: :desc)
        render "contacts/show", status: :unprocessable_entity
      end
    else
      # Creating note from notes/new page
      @note = Note.new(note_params)
      @note.user = current_user
    
      if @note.save
        redirect_to note_path(@note), notice: "Note was successfully created."
      else
        @contacts = current_user.contacts.order(:name)
        render :new, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /notes/1
  # Update an existing note
  def update
    if @note.update(note_params)
      redirect_to note_path(@note), notice: "Note was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  # Delete a note
  def destroy
    @note.destroy!
    redirect_to notes_url, notice: "Note was successfully deleted."
  end

  private

    # Find note by ID and ensure it belongs to current user
    def set_note
      @note = current_user.notes.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to notes_path, alert: "Note not found or you don't have permission to access it."
    end

    # Only allow note owners to edit or delete
    def authorize_note_owner!
      unless @note.user == current_user
        redirect_to notes_path, alert: "You are not allowed to perform this action."
      end
    end

    # Strong parameters: only allow expected attributes
    def note_params
      params.require(:note).permit(:content, :contact_id)
    end
end
