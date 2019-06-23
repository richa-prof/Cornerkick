class DetectorsController < CornerkickController
  before_action :set_detector, only: %i[show edit update destroy]
  before_action :set_account

  # GET /accounts/1/detectors
  def index
    @detectors = policy_scope(@account.detectors).page params[:page]
  end

  # GET /accounts/1/detectors/1
  def show
    authorize @detector
  end

  # GET /accounts/1/detectors/new
  def new
    @detector = Detector.new
    authorize @detector
  end

  # GET /accounts/1/detectors/1/edit
  def edit
    authorize @detector
  end

  # POST /accounts/1/detectors
  def create
    @detector = Detector.new(detector_params)
    @detector.account = @account
    authorize @detector

    if @detector.save
      redirect_to cornerkick.account_detector_path(@account, @detector), notice: 'Detector was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /accounts/1/detectors/1
  def update
    authorize @detector
    if @detector.update(detector_params)
      redirect_to cornerkick.account_detector_path(@account, @detector), notice: 'Detector was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /accounts/1/detectors/1
  def destroy
    authorize @detector
    @detector.destroy
    redirect_to cornerkick.account_detectors_url(@account), notice: 'Detector was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_detector
    @detector = Detector.find(params[:id])
  end

  def set_account
    @account = Account.find(params[:account_id])
  end

  # Only allow a trusted parameter "white list" through.
  def detector_params
    params.require(:detector).permit(:name, :description, :active)
  end
end
