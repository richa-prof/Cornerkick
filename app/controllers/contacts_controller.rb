class ContactsController < CornerkickController
  before_action :set_contact, only: %i[show edit update destroy]
  before_action :set_account

  # GET /accounts/1/contacts
  def index
    contacts = policy_scope(@account.contacts)
    contacts = contacts.where('email like :email', email: "%#{params[:q]}%") if params[:q].present?
    # contacts = contacts.where(email: params[:q]) if params[:q].present?

    @contacts = contacts.page params[:page]
  end

  # GET /accounts/1/contacts/1
  def show
    authorize @contact
  end

  # GET /accounts/1/contacts/new
  def new
    @contact = Contact.new
    authorize @contact
  end

  # GET /accounts/1/contacts/1/edit
  def edit
    authorize @contact
  end

  # POST /accounts/1/contacts
  def create
    @contact = Contact.new(contact_params)
    @contact.account = @account

    authorize @contact

    if @contact.save
      redirect_to account_contact_url(@account, @contact), notice: 'Contact was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /accounts/1/contacts/1
  def update
    authorize @contact
    if @contact.update(contact_params)
      redirect_to account_contact_url(@account, @contact), notice: 'Contact was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /accounts/1/contacts/1
  def destroy
    authorize @contact
    @contact.destroy
    redirect_to account_contacts_url, notice: 'Contact was successfully destroyed.'
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def set_account
    @account = Account.find(params[:account_id])
  end

  # Only allow a trusted parameter "white list" through.
  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone, :account_id, group_names: [])
  end
end
