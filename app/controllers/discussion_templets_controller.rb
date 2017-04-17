class DiscussionTempletsController < ApplicationController
  before_action :set_discussion_templet, only: [:show, :edit, :update, :destroy]

  # GET /discussion_templets
  # GET /discussion_templets.json
  def index
    @discussion_templets = DiscussionTemplet.all
  end

  # GET /discussion_templets/1
  # GET /discussion_templets/1.json
  def show
  end

  # GET /discussion_templets/new
  def new
    @discussion_templet = DiscussionTemplet.new
  end

  # GET /discussion_templets/1/edit
  def edit
  end

  # POST /discussion_templets
  # POST /discussion_templets.json
  def create
    @discussion_templet = DiscussionTemplet.new(discussion_templet_params)

    respond_to do |format|
      if @discussion_templet.save
        format.html { redirect_to @discussion_templet, notice: 'Discussion templet was successfully created.' }
        format.json { render :show, status: :created, location: @discussion_templet }
      else
        format.html { render :new }
        format.json { render json: @discussion_templet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discussion_templets/1
  # PATCH/PUT /discussion_templets/1.json
  def update
    respond_to do |format|
      if @discussion_templet.update(discussion_templet_params)
        format.html { redirect_to @discussion_templet, notice: 'Discussion templet was successfully updated.' }
        format.json { render :show, status: :ok, location: @discussion_templet }
      else
        format.html { render :edit }
        format.json { render json: @discussion_templet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussion_templets/1
  # DELETE /discussion_templets/1.json
  def destroy
    @discussion_templet.destroy
    respond_to do |format|
      format.html { redirect_to discussion_templets_url, notice: 'Discussion templet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion_templet
      @discussion_templet = DiscussionTemplet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discussion_templet_params
      params.require(:discussion_templet).permit(:code, :title, :content, :concept_explanation, :unit_concept_id, :answer, :level, :grade, :user_id, :creator_type)
    end
end
