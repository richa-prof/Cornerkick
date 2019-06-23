module Admin
  class ContactsController < AdminController
    before_action :set_contact, only: %i[show edit update destroy]

    # GET /contacts
    def index
      @contacts = policy_scope(Contact).includes(:account).page params[:page]
    end

    # GET /contacts/1
    def show
      authorize @contact
    end

    # GET /contacts/new
    def new
      @contact = Contact.new
      authorize @contact
    end

    # GET /contacts/1/edit
    def edit
      authorize @contact
    end

    # POST /contacts
    def create
      @contact = Contact.new(contact_params)
      authorize @contact

      if @contact.save
        redirect_to admin_contact_url(@contact), notice: 'Contact was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /contacts/1
    def update
      authorize @contact
      if @contact.update(contact_params)
        redirect_to admin_contact_url(@contact), notice: 'Contact was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /contacts/1
    def destroy
      authorize @contact
      @contact.destroy
      redirect_to admin_contacts_url, notice: 'Contact was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email, :phone, :account_id)
    end
  end
end
