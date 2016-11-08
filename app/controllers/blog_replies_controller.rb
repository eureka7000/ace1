class BlogRepliesController < ApplicationController
  before_action :set_blog_reply, only: [:show, :edit, :update, :destroy]

  # GET /blog_replies
  # GET /blog_replies.json
  def index
    @blog_replies = BlogReply.all
  end

  # GET /blog_replies/1
  # GET /blog_replies/1.json
  def show
  end

  # GET /blog_replies/new
  def new
    @blog_reply = BlogReply.new
  end

  # GET /blog_replies/1/edit
  def edit
  end

  # POST /blog_replies
  # POST /blog_replies.json
  def create
    @blog_reply = BlogReply.new(blog_reply_params)

    respond_to do |format|
      if @blog_reply.save
        format.html { redirect_to "/blogs/#{params[:blog_reply][:blog_id]}", notice: '댓글이 성공적으로 등록되었습니다.' }
        format.json { render :show, status: :created, location: @blog_reply }
      else
        format.html { render :new }
        format.json { render json: @blog_reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blog_replies/1
  # PATCH/PUT /blog_replies/1.json
  def update
    respond_to do |format|
      if @blog_reply.update(blog_reply_params)
        format.html { redirect_to @blog_reply, notice: 'Blog reply was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog_reply }
      else
        format.html { render :edit }
        format.json { render json: @blog_reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_replies/1
  # DELETE /blog_replies/1.json
  def destroy
    @blog_reply.destroy
    respond_to do |format|
      format.html { redirect_to blog_replies_url, notice: 'Blog reply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog_reply
      @blog_reply = BlogReply.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_reply_params
      params.require(:blog_reply).permit(:blog_id, :user_id, :comment, :group_id, :parent_reply_id, :depth, :order_no)
    end
end
