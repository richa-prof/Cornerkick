class CampaignTargetsController < CornerkickController
  before_action :set_campaign_target, only: %i[show edit update destroy]
  before_action :set_campaign

  # GET /accounts/1/campaigns/1/campaign_targets
  def index
    @campaign_targets = policy_scope(@campaign.campaign_targets)
  end

  # GET /accounts/1/campaigns/1/campaign_targets/1
  def show
    authorize @campaign_target
  end

  # GET /accounts/1/campaigns/1/campaign_targets/new
  def new
    @campaign_target = CampaignTarget.new
    @campaign_target.campaign = @campaign
    authorize @campaign_target
  end

  # GET /accounts/1/campaigns/1/campaign_targets/1/edit
  def edit
    authorize @campaign_target
  end

  # POST /accounts/1/campaigns/1/campaign_targets
  def create
    @campaign_target = CampaignTarget.new(campaign_target_params)
    @campaign_target.campaign = @campaign
    authorize @campaign_target

    if @campaign_target.save
      redirect_to account_campaign_path(@campaign.account, @campaign), notice: 'Campaign target was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /accounts/1/campaigns/1/campaign_targets/1
  def update
    authorize @campaign_target
    if @campaign_target.update(campaign_target_params)
      redirect_to account_campaign_path(@campaign.account, @campaign), notice: 'Campaign target was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /accounts/1/campaigns/1/campaign_targets/1
  def destroy
    authorize @campaign_target
    @campaign_target.destroy
    redirect_to account_campaign_url(@campaign.account, @campaign), notice: 'Campaign target was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_campaign_target
    @campaign_target = CampaignTarget.find(params[:id])
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  # Only allow a trusted parameter "white list" through.
  def campaign_target_params
    params.require(:campaign_target).permit(:landing_page)
  end
end
