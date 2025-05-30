class NotesController < ApplicationController
  before_action :set_note, only: %i[ show edit update destroy ]

  # GET /notes or /notes.json
  def index
    @notes = Note.all
  end

  # GET /notes/1 or /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new(contact_id: params[:contact_id])
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
  def create
   @note = Note.new(note_params)
   if @note.save
    contact = @note.contact
    contact.update(last_contacted_at: Time.current)

    redirect_to contact_path(contact), notice: "Note was successfully created."
   else
    @contact = @note.contact
    @notes = @contact.notes.order(created_at: :desc)
    render "contacts/show", status: :unprocessable_entity
   end
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: "Note was successfully updated." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note = Note.find(params[:id])
    contact = @note.contact
    @note.destroy!
    redirect_to contact_path(contact), notice: "Note was successfully deleted"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.expect(note: [ :content, :contact_id ])
    end
end
