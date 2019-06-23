class CampaignUrlsController < CornerkickController
  before_action :set_campaign_url, only: %i[show edit update destroy]
  before_action :set_campaign

  # GET /accounts/1/campaigns/1/campaign_urls/1
  def show
    authorize @campaign_url
  end

  # GET /accounts/1/campaigns/1/campaign_urls/1/edit
  def edit
    authorize @campaign_url
    @groups = @campaign.account.groups
  end

  # PATCH/PUT /accounts/1/campaigns/1/campaign_urls/1
  def update
    authorize @campaign_url
    if @campaign_url.update(campaign_url_params)
      redirect_to account_campaign_path(@campaign.account, @campaign), notice: 'Campaign URL was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /accounts/1/campaigns/1/campaign_urls/1
  def destroy
    authorize @campaign_url
    @campaign_url.destroy
    redirect_to account_campaign_path(@campaign.account, @campaign), notice: 'Campaign URL was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_campaign_url
    @campaign_url = CampaignUrl.find(params[:id])
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  # Only allow a trusted parameter "white list" through.
  def campaign_url_params
    params.require(:campaign_url).permit(:group_id, :url)
  end
end
