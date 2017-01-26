class ExamsController < ApplicationController
  before_action :authenticate_admin_user!, only: [:index, :show, :edit, :list, :new]
  before_action :authenticate_user!, only: [:previous_exams]
  before_action :set_exam, only: [:show, :edit, :update, :destroy]

  def previous_exams
    @org = params[:org]
    @year = params[:year]

    # @exams = Exam.all

    if !@org.blank? && !@year.blank?
      #번호 교차시켜서 DB 불러올 것
      @exams = Exam.where('org = ? and year = ?', @org, @year).order(:org, :year, :number)
      @partial = 'exams/both_org_year'
    else
      unless @org.blank?
        # @exams = Exam.where('org = ?', @org).order(:year, :number)
        @partial = 'exams/only_org'
      end

      unless @year.blank?
        # @exams = Exam.where('year = ?', @year).order(:org, :year, :number)
        @partial = 'exams/only_year'
      end
    end

    render layout: '/layouts/application'
  end

  def list
    @year = params[:year].to_i
    @exams = Exam.where('year = ?', @year.to_i).order(:exam_type, :number)
    render layout: '/layouts/admin_main'
  end

  # GET /exams
  # GET /exams.json
  def index
    @exams = Exam.all
    render layout: '/layouts/admin_main'
  end

  # GET /exams/1
  # GET /exams/1.json
  def show
    render layout: '/layouts/admin_main'
  end

  # GET /exams/new
  def new
    @exam = Exam.new
    @year = params[:year].to_i
    render layout: '/layouts/admin_main'
  end

  # GET /exams/1/edit
  def edit
    @year = params[:year].to_i
    render layout: '/layouts/admin_main'
  end

  # POST /exams
  # POST /exams.json
  def create
    @exam = Exam.new(exam_params)

    unless @exam.exam_image_id.blank?
      @exam_image = ExamImage.find(@exam.exam_image_id)
      @exam_image.exam_id = @exam_image.id
      @exam_image.save
    end

    respond_to do |format|
      if @exam.save
        format.html { redirect_to @exam, notice: 'Exam was successfully created.' }
        format.json { render :show, status: :created, location: @exam }
      else
        format.html { render :new }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exams/1
  # PATCH/PUT /exams/1.json
  def update
    respond_to do |format|
      if @exam.update(exam_params)

        unless @exam.exam_image_id.blank?
          @exam_image = ExamImage.find(@exam.exam_image_id)
          @exam_image.exam_id = @exam.id
          @exam_image.save
        end

        format.html { redirect_to @exam, notice: 'Exam was successfully updated.' }
        format.json { render :show, status: :ok, location: @exam }
      else
        format.html { render :edit }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.json
  def destroy
    @exam.destroy
    respond_to do |format|
      format.html { redirect_to exams_url, notice: 'Exam was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_params
      params.require(:exam).permit(:year, :month, :exam_type, :number, :score, :contents, :exam_image_id, :org)
    end
end
