class GroupsController < CornerkickController
  before_action :set_group, only: %i[show edit update destroy]
  before_action :set_account

  # GET /accounts/1/groups
  def index
    @groups = policy_scope(@account.groups).page params[:page]
  end

  # GET /accounts/1/groups/1
  def show
    authorize @group
    @contacts = @group.contacts.page params[:page]
  end

  # GET /accounts/1/groups/new
  def new
    @group = Group.new
    authorize @group
  end

  # GET /accounts/1/groups/1/edit
  def edit
    authorize @group
  end

  # POST /accounts/1/groups
  def create
    @group = Group.new(group_params)
    @group.account = @account
    authorize @group

    if @group.save
      redirect_to cornerkick.account_group_path(@account, @group), notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /accounts/1/groups/1
  def update
    authorize @group
    if @group.update(group_params)
      redirect_to cornerkick.account_group_path(@account, @group), notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /accounts/1/groups/1
  def destroy
    authorize @group
    @group.destroy
    redirect_to cornerkick.account_groups_url(@account), notice: 'Group was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  def set_account
    @account = Account.find(params[:account_id])
  end

  # Only allow a trusted parameter "white list" through.
  def group_params
    params.require(:group).permit(:name, :description)
  end
end
