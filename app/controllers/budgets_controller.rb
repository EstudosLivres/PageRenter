class BudgetsController < ApplicationController
  before_action :set_budget, only: [:show, :edit, :update, :destroy]
  before_action :setup_aux_objs

  # GET /budgets
  # GET /budgets.json
  def index
    @budgets = Budget.all
  end

  # GET /budgets/1
  # GET /budgets/1.json
  def show
  end

  # GET /budgets/new
  def new
    # Check if it is on security URL
    if request.url.index('https://').nil? && Rails.env.production?
      redirect_to request.url.gsub! 'http://', 'https://'
    end
  end

  # GET /budgets/1/edit
  def edit
  end

  # POST /budgets
  # POST /budgets.json
  def create
    @budget = Budget.new(budget_params)

    respond_to do |format|
      if @budget.save
        format.html { redirect_to root_url, notice: {type: :success, strong: 'Congratulations!', msg: 'Budget was successfully updated.'} }
        format.json { render action: 'show', status: :created, location: @budget }
      else
        format.html { render action: 'new', notice: {type: :danger, strong: 'Oops!', msg: 'Something went wrong.'} }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /budgets/1
  # PATCH/PUT /budgets/1.json
  def update
    @budget = Budget.new(budget_params)

    respond_to do |format|
      if @budget.save
        format.html { redirect_to root_url, notice: {type: :success, strong: 'Congratulations!', msg: 'Budget was successfully updated.'} }
        format.json { render action: 'show', status: :created, location: @budget }
      else
        format.html { render action: 'new', notice: {type: :danger, strong: 'Oops!', msg: 'Something went wrong.'} }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1
  # DELETE /budgets/1.json
  def destroy
    @budget.destroy
    respond_to do |format|
      format.html { redirect_to budgets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget
      @budget = Budget.find(params[:id])
    end

    # Create objs to auxiliary on create forms
    def setup_aux_objs
      @campaign = Campaign.find(params[:campaign_id])
      @card_flags = CardFlag.all
      @budget = @campaign.budgets.last
      @budget = Budget.new if @budget.nil?
      @currencies = Currency.all
      @recurrence_periods = RecurrencePeriod.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def budget_params
      budget_params_hash = params.require(:budget).permit(:value, :currency_id, :recurrence_period_id, :card_flag_id, :taxes_paid)
      budget_params_hash[:active] = true
      budget_params_hash[:closed_date] = nil
      budget_params_hash[:campaign_id] = params[:campaign_id]
      budget_params_hash[:value] = Rents::Currency.to_operator_str budget_params_hash[:value]
      return budget_params_hash
    end
end
