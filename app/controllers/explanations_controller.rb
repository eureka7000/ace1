class ExplanationsController < ApplicationController
  before_action :set_explanation, only: [:show, :edit, :update, :destroy]

  # GET /explanations
  # GET /explanations.json
  def index
    @explanations = Explanation.all
  end

  # GET /explanations/1
  # GET /explanations/1.json
  def show
  end

  # GET /explanations/new
  def new
    @explanation = Explanation.new
  end

  # GET /explanations/1/edit
  def edit
  end

  # POST /explanations
  # POST /explanations.json
  def create
    @explanation = Explanation.new(explanation_params)
    @unit_concept = UnitConcept.find(params[:explanation][:unit_concept_id])

    respond_to do |format|
      if @explanation.save
        format.html { redirect_to @explanation, notice: 'Explanation was successfully created.' }
        format.json { render :show, status: :created, location: @explanation }
      else
        format.html { render :new }
        format.json { render json: @explanation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /explanations/1
  # PATCH/PUT /explanations/1.json
  def update
    respond_to do |format|
      if @explanation.update(explanation_params)
        format.html { redirect_to @explanation, notice: 'Explanation was successfully updated.' }
        format.json { render :show, status: :ok, location: @explanation }
      else
        format.html { render :edit }
        format.json { render json: @explanation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /explanations/1
  # DELETE /explanations/1.json
  def destroy
    @explanation.destroy
    respond_to do |format|
      format.html { redirect_to explanations_url, notice: 'Explanation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_explanation
      @explanation = Explanation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def explanation_params
      params.require(:explanation).permit(:code, :file_name, :unit_concept_id)
    end
end
