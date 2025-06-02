class ContactsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :contact_not_found

  # Require authentication for all actions
  before_action :authenticate_user!, except: %i[index show]


  before_action :set_contact, only: %i[ show edit update destroy ]

# GET /contacts or /contacts.json
  def index
    @show_active_only = params[:active] == "1"

    scope = current_user.contacts
    scope = scope.where(active: true) if @show_active_only

    if params[:query].present?
      query = "%#{params[:query].downcase}%"
      scope = scope.where(
        "LOWER(name) LIKE :query OR LOWER(email) LIKE :query OR LOWER(company) LIKE :query",
        query: query
      )
    end

    @contacts = scope.order(:name)
  end


  # GET /contacts/1 or /contacts/1.json
  def show
    @notes = @contact.notes.order(created_at: :desc)
    @note = @contact.notes.build
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    @contact.user = current_user
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts or /contacts.json
  def create
    @contact = Contact.new(contact_params)
    @contact.user = current_user

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: "Contact was successfully created." }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1 or /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: "Contact was successfully updated." }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1 or /contacts/1.json
  def destroy
    @contact.destroy!

    respond_to do |format|
      format.html { redirect_to contacts_path, status: :see_other, notice: "Contact was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_not_found
      redirect_to contacts_url, alert: "Contact not found."
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :company, :birthday, :active)
    end
end
