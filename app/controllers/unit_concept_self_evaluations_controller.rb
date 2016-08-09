class UnitConceptSelfEvaluationsController < ApplicationController
  before_action :set_unit_concept_self_evaluation, only: [:show, :edit, :update, :destroy]

  # GET /unit_concept_self_evaluations
  # GET /unit_concept_self_evaluations.json
  def index
    @unit_concept_self_evaluations = UnitConceptSelfEvaluation.all
  end

  # GET /unit_concept_self_evaluations/1
  # GET /unit_concept_self_evaluations/1.json
  def show
  end

  # GET /unit_concept_self_evaluations/new
  def new
    @unit_concept_self_evaluation = UnitConceptSelfEvaluation.new
  end

  # GET /unit_concept_self_evaluations/1/edit
  def edit
  end

  # POST /unit_concept_self_evaluations
  # POST /unit_concept_self_evaluations.json
  def create
    @unit_concept_self_evaluation = UnitConceptSelfEvaluation.new(unit_concept_self_evaluation_params)

    #데이터를 보낸 url 주소를 받는다, 질문하기가 이용되는 곳이 여러곳이므로 보낸 주소를 받아 리턴해준다.
    url = params[:url]

    respond_to do |format|
      if @unit_concept_self_evaluation.save
        format.html { redirect_to url, notice: 'Unit concept self evaluation was successfully created.' }
        format.json { render :show, status: :created, location: @unit_concept_self_evaluation }
      else
        format.html { render :new }
        format.json { render json: @unit_concept_self_evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unit_concept_self_evaluations/1
  # PATCH/PUT /unit_concept_self_evaluations/1.json
  def update
    respond_to do |format|
      if @unit_concept_self_evaluation.update(unit_concept_self_evaluation_params)
        format.html { redirect_to @unit_concept_self_evaluation, notice: 'Unit concept self evaluation was successfully updated.' }
        format.json { render :show, status: :ok, location: @unit_concept_self_evaluation }
      else
        format.html { render :edit }
        format.json { render json: @unit_concept_self_evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unit_concept_self_evaluations/1
  # DELETE /unit_concept_self_evaluations/1.json
  def destroy
    @unit_concept_self_evaluation.destroy
    respond_to do |format|
      format.html { redirect_to unit_concept_self_evaluations_url, notice: 'Unit concept self evaluation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit_concept_self_evaluation
      @unit_concept_self_evaluation = UnitConceptSelfEvaluation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_concept_self_evaluation_params
      params.require(:unit_concept_self_evaluation).permit(:unit_concept_id, :evaluation, :comment, :user_id)
    end
end
