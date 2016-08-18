class StudyHistoriesController < ApplicationController
    
    before_filter :authenticate_user!
    before_action :set_study_history, only: [:show, :edit, :update, :destroy]
    
    def create
        
        ret = {} 
        
        if StudyHistory.update_study_history(params[:study_history])
            ret = { status: 'ok' }            
        else 
            ret = { status: 'fail' }
        end    
        
        render json: ret            

    end
    

  # GET /study_histories
  # GET /study_histories.json
  def index
    @study_histories = StudyHistory.all
  end

  # GET /study_histories/1
  # GET /study_histories/1.json
  def show
  end

  # GET /study_histories/new
  def new
    @study_history = StudyHistory.new
  end

  # GET /study_histories/1/edit
  def edit
  end

  # PATCH/PUT /study_histories/1
  # PATCH/PUT /study_histories/1.json
  def update
    respond_to do |format|
      if @study_history.update(study_history_params)
        format.html { redirect_to @study_history, notice: 'Study history was successfully updated.' }
        format.json { render :show, status: :ok, location: @study_history }
      else
        format.html { render :edit }
        format.json { render json: @study_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /study_histories/1
  # DELETE /study_histories/1.json
  def destroy
    @study_history.destroy
    respond_to do |format|
      format.html { redirect_to study_histories_url, notice: 'Study history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_study_history
      @study_history = StudyHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def study_history_params
      params.require(:study_history).permit(:user_id, :unit_concept_id, :segment, :status)
    end
end
