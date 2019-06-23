module Admin
  class UsersController < AdminController
    before_action :set_user, only: %i[show edit update destroy]

    # GET /users
    def index
      @users = policy_scope(User).page params[:page]
    end

    # GET /users/1
    def show
      authorize @user
    end

    # GET /users/new
    def new
      @user = User.new
      authorize @user
    end

    # GET /users/1/edit
    def edit
      authorize @user
    end

    # POST /users
    def create
      @user = User.new(user_params)
      authorize @user

      if @user.save
        redirect_to admin_user_url(@user), notice: 'User was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /users/1
    def update
      authorize @user
      if @user.update(user_params)
        redirect_to admin_user_url(@user), notice: 'User was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /users/1
    def destroy
      authorize @user
      @user.destroy
      redirect_to admin_users_url, notice: 'User was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :site_admin, :password)
    end
  end
end
