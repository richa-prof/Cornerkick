class CampaignsController < CornerkickController
  before_action :set_campaign, only: %i[show edit update destroy generate_urls]
  before_action :set_account

  # GET /accounts/1/campaigns
  def index
    @campaigns = policy_scope(@account.campaigns).page params[:page]
  end

  # GET /accounts/1/campaigns/1
  def show
    authorize @campaign
  end

  # GET /accounts/1/campaigns/new
  def new
    @campaign = Campaign.new
    @campaign.account = @account
    authorize @campaign
  end

  # GET /accounts/1/campaigns/1/edit
  def edit
    authorize @campaign
  end

  # POST /accounts/1/campaigns
  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.account = @account
    authorize @campaign

    if @campaign.save
      redirect_to account_campaign_path(@account, @campaign), notice: 'Campaign was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /accounts/1/campaigns/1
  def update
    authorize @campaign
    if @campaign.update(campaign_params)
      redirect_to account_campaign_path(@account, @campaign), notice: 'Campaign was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /accounts/1/campaigns/1
  def destroy
    authorize @campaign
    @campaign.destroy
    redirect_to account_campaigns_url(@account), notice: 'Campaign was successfully destroyed.'
  end

  # POST /accounts/1/campaigns/1/generate_urls
  def generate_urls
    authorize @campaign
    @campaign.generate_campaign_urls
    redirect_to account_campaign_url(@account, @campaign), notice: 'Campaign URLs generated successfully'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def set_account
    @account = Account.find(params[:account_id])
  end

  # Only allow a trusted parameter "white list" through.
  def campaign_params
    params.require(:campaign).permit(:name, :active, :started_at, :ended_at)
  end
end
