class CampaignSourcesController < CornerkickController
  before_action :set_campaign_source, only: %i[show edit update destroy]
  before_action :set_campaign

  # GET /accounts/1/campaigns/1/campaign_sources
  def index
    @campaign_sources = policy_scope(@campaign.campaign_sources)
  end

  # GET /accounts/1/campaigns/1/campaign_sources/1
  def show
    authorize @campaign_source
  end

  # GET /accounts/1/campaigns/1/campaign_sources/new
  def new
    @campaign_source = CampaignSource.new
    authorize @campaign_source
  end

  # GET /accounts/1/campaigns/1/campaign_sources/1/edit
  def edit
    authorize @campaign_source
  end

  # POST /accounts/1/campaigns/1/campaign_sources
  def create
    @campaign_source = CampaignSource.new(campaign_source_params)
    @campaign_source.campaign = @campaign
    authorize @campaign_source

    if @campaign_source.save
      redirect_to account_campaign_path(@campaign.account, @campaign), notice: 'Campaign source was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /accounts/1/campaigns/1/campaign_sources/1
  def update
    authorize @campaign_source
    if @campaign_source.update(campaign_source_params)
      redirect_to account_campaign_path(@campaign.account, @campaign), notice: 'Campaign source was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /accounts/1/campaigns/1/campaign_sources/1
  def destroy
    authorize @campaign_source
    @campaign_source.destroy
    redirect_to account_campaign_url(@campaign.account, @campaign), notice: 'Campaign source was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_campaign_source
    @campaign_source = CampaignSource.find(params[:id])
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  # Only allow a trusted parameter "white list" through.
  def campaign_source_params
    params.require(:campaign_source).permit(:name)
  end
end
