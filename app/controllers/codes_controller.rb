class CodesController < ApplicationController
    
    before_action :authenticate_admin_user!, only: [:index, :show, :edit, :update, :destroy]
    before_action :set_code, only: [:show, :edit, :update, :destroy]
    
    layout '/layouts/admin_main'

    def index
        page = params[:page].blank? ? 1 : params[:page]
        @codes = Code.all.paginate( :page => page, :per_page => 30 ).order(id: :desc)
    end

    def show
    end

  # GET /codes/new
  def new
    @code = Code.new
  end

  # GET /codes/1/edit
  def edit
  end

  # POST /codes
  # POST /codes.json
  def create
    @code = Code.new(code_params)

    respond_to do |format|
      if @code.save
        format.html { redirect_to @code, notice: 'Code was successfully created.' }
        format.json { render :show, status: :created, location: @code }
      else
        format.html { render :new }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /codes/1
  # PATCH/PUT /codes/1.json
  def update
    respond_to do |format|
      if @code.update(code_params)
        format.html { redirect_to @code, notice: 'Code was successfully updated.' }
        format.json { render :show, status: :ok, location: @code }
      else
        format.html { render :edit }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

    # DELETE /codes/1
    # DELETE /codes/1.json
    def destroy
        @code.use_yn = 'N'
        @code.save
        
        respond_to do |format|
            format.html { redirect_to codes_url, notice: 'Code was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
        
    # Use callbacks to share common setup or constraints between actions.
    def set_code
        @code = Code.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def code_params
        params.require(:code).permit(:category, :code_name, :use_yn)
    end
    
end
