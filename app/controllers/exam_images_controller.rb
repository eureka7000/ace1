class ExamImagesController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_exam_image, only: [:show, :edit, :update, :destroy]

  # GET /exam_images
  # GET /exam_images.json
  def index
    @exam_images = ExamImage.all
  end

  # GET /exam_images/1
  # GET /exam_images/1.json
  def show
  end

  # GET /exam_images/new
  def new
    @exam_image = ExamImage.new
  end

  # GET /exam_images/1/edit
  def edit
  end

  # POST /exam_images
  # POST /exam_images.json
  def create
    @exam_image = ExamImage.new(exam_image_params)

    respond_to do |format|
      if @exam_image.save

        # logger.info "#################  filename: #{@exam_image.filename}  ####################"

        ret = @exam_image.filename.to_s

        logger.info "#################  filename: #{ret}  ####################"

        format.json { render :json => { id: @exam_image.id, url: ret } }

      end
    end
  end

  # PATCH/PUT /exam_images/1
  # PATCH/PUT /exam_images/1.json
  def update
    respond_to do |format|
      if @exam_image.update(exam_image_params)
        format.html { redirect_to @exam_image, notice: 'Exam image was successfully updated.' }
        format.json { render :show, status: :ok, location: @exam_image }
      else
        format.html { render :edit }
        format.json { render json: @exam_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exam_images/1
  # DELETE /exam_images/1.json
  def destroy
    @exam_image.destroy
    respond_to do |format|
      format.html { redirect_to exam_images_url, notice: 'Exam image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam_image
      @exam_image = ExamImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_image_params
      params.require(:exam_image).permit(:filename, :width, :height)
    end
end
