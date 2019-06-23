module Admin
  class TrackersController < AdminController
    before_action :set_tracker, only: %i[show edit update destroy]

    # GET /trackers
    def index
      @trackers = policy_scope(Tracker).page params[:page]
    end

    # GET /trackers/1
    def show
      authorize @tracker
    end

    # GET /trackers/new
    def new
      @tracker = Tracker.new
      authorize @tracker
    end

    # GET /trackers/1/edit
    def edit
      authorize @tracker
    end

    # POST /trackers
    def create
      @tracker = Tracker.new(tracker_params)
      authorize @tracker

      if @tracker.save
        redirect_to admin_tracker_url(@tracker), notice: 'Tracker was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /trackers/1
    def update
      authorize @tracker
      if @tracker.update(tracker_params)
        redirect_to admin_tracker_url(@tracker), notice: 'Tracker was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /trackers/1
    def destroy
      authorize @tracker
      @tracker.destroy
      redirect_to admin_trackers_url, notice: 'Tracker was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_tracker
      @tracker = Tracker.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tracker_params
      params.require(:tracker).permit(:identifier, :account_id)
    end
  end
end
