class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :like]
  before_action :authenticate_admin_user!, only: [:index]

  # GET /blogs
  # GET /blogs.json

  def like
    if @blog.like.nil?
      @blog.like = 1
    else
      @blog.like = @blog.like + 1
    end

    @blog.save

    ret = { status: "ok" }

    render :json => ret

  end

  def index

    blog_type = params[:blog_type]

    if blog_type.nil?
      @blogs = Blog.all.paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 30 ).order(id: :desc)
      @admin = '1';
    else
      str = ""
      unless blog_type.blank?
        str = "blog_type = '#{blog_type}'"
      end
      @blogs = Blog.where(str).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 30 ).order(id: :desc)
    end
    @blog_types = Blog.group('blog_type')

    render layout: 'admin_main'
  end


  def show

      @blog_type = params[:blog_type]

      if @blog.admin_yn == "Y"
          @user = Admin.find(@blog.user_id)
      else
          @user = User.find(@blog.user_id)
      end

      @replies1 = BlogReply.where('blog_id = ? and depth = ?', params[:id], 1)
      @latest_news = Blog.order(id: :desc).first(5)

      unless session[:admin].nil?
          render layout: 'admin_main'
      end
  end


  # GET /blogs/new
  def new
    @blog = Blog.new
    @blog_type = params[:blog_type]

    @admin = params[:admin]
    unless @admin.blank?
      render layout: 'admin_main'
    end

  end

  def edit
      unless session[:admin].nil?
          render layout: 'admin_main'
      end
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    @admin = params[:admin]

    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog,notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def learning_problem_solution
      @blog_type = '1'
      @blogs = Blog.where('blog_type = ?', @blog_type).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 10 ).order(id: :desc)
     # @questions = Question.where('to_user_id = ? || user_id = ?', current_user.id, current_user.id).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 10 ).order(created_at: :desc)
      @latest_news = Blog.where('blog_type !=?', '8').order(id: :desc).first(5)
  end

  def succession_case
      @blog_type = '2'
      @blogs = Blog.where('blog_type = ?', @blog_type).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 10 ).order(id: :desc)
      @latest_news = Blog.where('blog_type !=?', '8').order(id: :desc).first(5)
  end

  def math_story
    @blog_type = '3'
    @blogs = Blog.where('blog_type = ?', @blog_type).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 10 ).order(id: :desc)
    @latest_news = Blog.where('blog_type !=?', '8').order(id: :desc).first(5)
  end

  def faq
    @blog_type = '4'
    @blogs = Blog.where('blog_type = ?', @blog_type).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 10 ).order(id: :desc)
    @latest_news = Blog.where('blog_type !=?', '8').order(id: :desc).first(5)
  end

  def notice
    @blog_type = '5'
    @blogs = Blog.where('blog_type = ?', @blog_type).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 5 ).order(created_at: :desc)
    @latest_news = Blog.where('blog_type !=?', '8').order(id: :desc).first(5)
  end

  def the_news
    @blog_type = '6'
    @blogs = Blog.where('blog_type = ?', @blog_type).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 10 ).order(id: :desc)
    @latest_news = Blog.where('blog_type !=?', '8').order(id: :desc).first(5)
  end

  def company_introduction
    @blog_type = '7'
    @blogs = Blog.where('blog_type = ?', @blog_type).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 10 ).order(id: :desc)
    @latest_news = Blog.where('blog_type !=?', '8').order(id: :desc).first(5)
  end

  # POST /blogs/contact_us_message
  def contact_us_message
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        user = User.find(@blog.user_id)
        UserMailer.noti_contact_us_message(user, @blog).deliver_later!
        format.html { redirect_to '/blogs/contact_us?mail=send_ok' }
      else
        format.html { redirect_to '/blogs/contact_us?mail=send_fail' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:blog_type, :title, :content, :user_id, :admin_yn, :file_name)
    end
end
