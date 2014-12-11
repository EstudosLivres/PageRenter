class BidsController < ApplicationController
  #before_action :set_bid, only: [:show, :edit, :update, :destroy]
  before_action :set_bid, except: [:new, :create]
  before_action :set_aux_objs

  # GET /bids
  # GET /bids.json
  def index
    @bids = Bid.all
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
  end

  # GET /bids/new
  def new
    @bid = Bid.new
  end

  # GET /bids/1/edit
  def edit
  end

  # POST /bids
  # POST /bids.json
  def create
    @bid = Bid.new(bid_params)

    respond_to do |format|
      if @bid.save
        format.html { redirect_to campaign_ad_path(params[:campaign_id], params[:ad_id]), notice: 'Bid was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bid }
      else
        format.html { render action: 'new' }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bids/1
  # PATCH/PUT /bids/1.json
  def update
    @bid = Bid.new(bid_params)

    respond_to do |format|
      if @bid.save
        format.html { redirect_to campaign_ad_path(params[:campaign_id], params[:ad_id]), notice: 'Bid was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @bid }
      else
        format.html { render action: 'new', notice: {type: :danger, strong: 'Oops!', msg: 'Something went wrong.'} }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Create objs to auxiliary on create forms
    def set_aux_objs
      @ad = Ad.find(params[:ad_id]) unless params[:ad_id].nil?
      @campaign = Campaign.find(params[:campaign_id]) unless params[:campaign_id].nil?
      @currencies = Currency.all
      # TODO return if !valid_user_permission?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      aux_bid_params = params.require(:bid).permit(:per_visitation, :per_impression, :per_foreign_interaction, :per_local_interaction, :per_conversion, :currency_id)
      aux_bid_params[:ad_id] = params[:ad_id]

      # Setting the RentS operator format
      aux_bid_params[:per_visitation] = Rents::Currency.to_operator_str aux_bid_params[:per_visitation]
      aux_bid_params[:per_impression] = Rents::Currency.to_operator_str aux_bid_params[:per_impression]
      aux_bid_params[:per_foreign_interaction] = Rents::Currency.to_operator_str aux_bid_params[:per_foreign_interaction]
      aux_bid_params[:per_local_interaction] = Rents::Currency.to_operator_str aux_bid_params[:per_local_interaction]
      aux_bid_params[:per_conversion] = Rents::Currency.to_operator_str aux_bid_params[:per_conversion]
      return aux_bid_params
    end
end
