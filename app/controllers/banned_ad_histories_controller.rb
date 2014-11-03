class BannedAdHistoriesController < ApplicationController
  before_action :set_banned_ad_history, only: [:show, :edit, :update, :destroy]

  # GET /banned_ad_histories
  # GET /banned_ad_histories.json
  def index
    @banned_ad_histories = BannedAdHistory.all
  end

  # GET /banned_ad_histories/1
  # GET /banned_ad_histories/1.json
  def show
  end

  # GET /banned_ad_histories/new
  def new
    @banned_ad_history = BannedAdHistory.new
  end

  # GET /banned_ad_histories/1/edit
  def edit
  end

  # POST /banned_ad_histories
  # POST /banned_ad_histories.json
  def create
    @banned_ad_history = BannedAdHistory.new(banned_ad_history_params)

    respond_to do |format|
      if @banned_ad_history.save
        format.html { redirect_to @banned_ad_history, notice: 'Banned ad history was successfully created.' }
        format.json { render action: 'show', status: :created, location: @banned_ad_history }
      else
        format.html { render action: 'new' }
        format.json { render json: @banned_ad_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banned_ad_histories/1
  # PATCH/PUT /banned_ad_histories/1.json
  def update
    respond_to do |format|
      if @banned_ad_history.update(banned_ad_history_params)
        format.html { redirect_to @banned_ad_history, notice: 'Banned ad history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @banned_ad_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banned_ad_histories/1
  # DELETE /banned_ad_histories/1.json
  def destroy
    @banned_ad_history.destroy
    respond_to do |format|
      format.html { redirect_to banned_ad_histories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_banned_ad_history
      @banned_ad_history = BannedAdHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def banned_ad_history_params
      params.require(:banned_ad_history).permit(:reason, :description, :user_id, :ad_id)
    end
end
