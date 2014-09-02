class SegmentsController < ApplicationController
  before_action :set_segment, except: [:new, :index]

  # GET /segments/:id/add_range
  def add_range
  end

  # POST /segments/:id/add_range
  def improve_range
    @segment.setup_uids(params[:segment][:uids].split)

    respond_to do |format|
      if @segment.save
        format.html { redirect_to @segment, notice: 'Segment range was IMPROVED.' }
        format.json { render action: 'show', status: :created, location: @segment }
      else
        format.html { render action: 'add_range' }
        format.json { render json: @segment.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /segments
  # GET /segments.json
  def index
    @segments = Segment.all
  end

  # GET /segments/1
  # GET /segments/1.json
  def show
  end

  # GET /segments/new
  def new
    @segment = Segment.new
  end

  # GET /segments/1/edit
  def edit
  end

  # POST /segments
  # POST /segments.json
  def create
    @segment = Segment.new(segment_params)
    @segment.setup_uids(params[:segment][:uids].split)

    respond_to do |format|
      if @segment.save
        format.html { redirect_to @segment, notice: 'Segment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @segment }
      else
        format.html { render action: 'new' }
        format.json { render json: @segment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /segments/1
  # PATCH/PUT /segments/1.json
  def update
    respond_to do |format|
      if @segment.update(segment_params)
        format.html { redirect_to @segment, notice: 'Segment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @segment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /segments/1
  # DELETE /segments/1.json
  def destroy
    @segment.destroy
    respond_to do |format|
      format.html { redirect_to segments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_segment
      !params[:id].nil? ? id = params[:id] : id = params[:segment_id]
      @segment = Segment.find(id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def segment_params
      params.require(:segment).permit(:name, :description)
    end
end
