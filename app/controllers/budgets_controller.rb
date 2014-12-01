class BudgetsController < ApplicationController
  before_action :set_budget, only: [:show, :edit, :update, :destroy]
  before_action :setup_aux_objs, only: [:new, :create, :edit, :update]

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
        format.html { render action: 'new' }
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
        format.html { render action: 'new' }
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
      @budget = @campaign.budgets.last
      @budget = Budget.new if @budget.nil?
      @currencies = Currency.all
      @recurrence_periods = RecurrencePeriod.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def budget_params
      budget_params_hash = params.require(:budget).permit(:value, :currency_id, :recurrence_period_id)
      budget_params_hash[:activated] = true
      budget_params_hash[:closed_date] = nil
      budget_params_hash[:campaign_id] = params[:campaign_id]
      budget_params_hash[:value] = budget_params_hash[:value].remove('.').remove(',')
      return budget_params_hash
    end
end
