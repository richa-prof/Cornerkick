module Admin
  class GroupsController < AdminController
    before_action :set_group, only: %i[show edit update destroy]

    # GET /groups
    def index
      @groups = policy_scope(Group).includes(:account).page params[:page]
    end

    # GET /groups/1
    def show
      authorize @group
    end

    # GET /groups/new
    def new
      @group = Group.new
      authorize @group
    end

    # GET /groups/1/edit
    def edit
      authorize @group
    end

    # POST /groups
    def create
      @group = Group.new(group_params)
      authorize @group

      if @group.save
        redirect_to admin_group_url(@group), notice: 'Group was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /groups/1
    def update
      authorize @group
      if @group.update(group_params)
        redirect_to admin_group_url(@group), notice: 'Group was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /groups/1
    def destroy
      authorize @group
      @group.destroy
      redirect_to admin_groups_url, notice: 'Group was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def group_params
      params.require(:group).permit(:name, :description, :account_id)
    end
  end
end
