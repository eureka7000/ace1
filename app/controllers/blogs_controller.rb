class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin_user!, only: [:index]

  # GET /blogs
  # GET /blogs.json

  def index
    @admin = '1';

    blog_type = params[:blog_type]

    if blog_type.nil?
      @blogs = Blog.all.paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 30 ).order(id: :desc)
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

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blog_type = params[:blog_type]

    @admin = params[:admin]
    unless @admin.blank?
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

  # GET /blogs/1/edit
  def edit
    @admin = params[:admin]
    unless @admin.blank?
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
  end

  def succession_case
    @blog_type = '2'
    @blogs = Blog.where('blog_type = ?', @blog_type).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 10 ).order(id: :desc)

  end

  def math_story
    @blog_type = '3'
    @blogs = Blog.where('blog_type = ?', @blog_type).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 10 ).order(id: :desc)

  end

  def faq
    @blog_type = '4'
    @blogs = Blog.where('blog_type = ?', @blog_type).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 10 ).order(id: :desc)

  end

  def notice
    @blog_type = '5'
    @blogs = Blog.where('blog_type = ?', @blog_type).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 10 ).order(id: :desc)

  end

  def the_news
    @blog_type = '6'
    @blogs = Blog.where('blog_type = ?', @blog_type).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 10 ).order(id: :desc)

  end

  def company_introduction
    @blog_type = '7'
    @blogs = Blog.where('blog_type = ?', @blog_type).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 10 ).order(id: :desc)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:blog_type, :title, :content, :user_id)
    end
end
