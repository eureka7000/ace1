class DiscussionImagesController < ApplicationController
  before_action :set_discussion_image, only: [:show, :edit, :update, :destroy]

  # GET /discussion_images
  # GET /discussion_images.json
  def index
    @discussion_images = DiscussionImage.all
  end

  # GET /discussion_images/1
  # GET /discussion_images/1.json
  def show
  end

  # GET /discussion_images/new
  def new
    @discussion_image = DiscussionImage.new
  end

  # GET /discussion_images/1/edit
  def edit
  end

  # POST /discussion_images
  # POST /discussion_images.json
  def create
    @discussion_image = DiscussionImage.new(discussion_image_params)

    respond_to do |format|
      if @discussion_image.save

        ret = @discussion_image.filename.to_s

        logger.info "#################  filename: #{ret}  ####################"

        format.json { render :json => { id: @discussion_image.id, url: ret } }

      end
    end
  end

  # PATCH/PUT /discussion_images/1
  # PATCH/PUT /discussion_images/1.json
  def update
    respond_to do |format|
      if @discussion_image.update(discussion_image_params)
        format.html { redirect_to @discussion_image, notice: 'Discussion image was successfully updated.' }
        format.json { render :show, status: :ok, location: @discussion_image }
      else
        format.html { render :edit }
        format.json { render json: @discussion_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussion_images/1
  # DELETE /discussion_images/1.json
  def destroy
    @discussion_image.destroy
    respond_to do |format|
      format.html { redirect_to discussion_images_url, notice: 'Discussion image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion_image
      @discussion_image = DiscussionImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discussion_image_params
      params.require(:discussion_image).permit(:discussion_id, :filename, :width, :height)
    end
end
