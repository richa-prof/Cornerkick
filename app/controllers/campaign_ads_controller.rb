class CampaignAdsController < CornerkickController
  before_action :set_campaign_ad, only: %i[show edit update destroy]
  before_action :set_campaign

  # GET /accounts/1/campaigns/1/campaign_ads
  def index
    @campaign_ads = policy_scope(@campaign.campaign_ads)
  end

  # GET /accounts/1/campaigns/1/campaign_ads/1
  def show
    authorize @campaign_ad
  end

  # GET /accounts/1/campaigns/1/campaign_ads/new
  def new
    @campaign_ad = CampaignAd.new
    @campaign_ad.campaign = @campaign
    authorize @campaign_ad
  end

  # GET /accounts/1/campaigns/1/campaign_ads/1/edit
  def edit
    authorize @campaign_ad
  end

  # POST /accounts/1/campaigns/1/campaign_ads
  def create
    @campaign_ad = CampaignAd.new(campaign_ad_params)
    @campaign_ad.campaign = @campaign
    authorize @campaign_ad

    if @campaign_ad.save
      redirect_to account_campaign_path(@campaign.account, @campaign), notice: 'Campaign ad was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /accounts/1/campaigns/1/campaign_ads/1
  def update
    authorize @campaign_ad
    if @campaign_ad.update(campaign_ad_params)
      redirect_to account_campaign_path(@campaign.account, @campaign), notice: 'Campaign ad was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /accounts/1/campaigns/1/campaign_ads/1
  def destroy
    authorize @campaign_ad
    @campaign_ad.destroy
    redirect_to account_campaign_url(@campaign.account, @campaign), notice: 'Campaign ad was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_campaign_ad
    @campaign_ad = CampaignAd.find(params[:id])
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  # Only allow a trusted parameter "white list" through.
  def campaign_ad_params
    params.require(:campaign_ad).permit(:name)
  end
end
