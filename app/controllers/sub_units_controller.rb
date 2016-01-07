class SubUnitsController < ApplicationController
  before_action :set_sub_unit, only: [:show, :edit, :update, :destroy]

  # GET /sub_units
  # GET /sub_units.json
  def index
    @sub_units = SubUnit.all
  end

  # GET /sub_units/1
  # GET /sub_units/1.json
  def show
  end

  # GET /sub_units/new
  def new
    @sub_unit = SubUnit.new
  end

  # GET /sub_units/1/edit
  def edit
  end

  # POST /sub_units
  # POST /sub_units.json
  def create
    @sub_unit = SubUnit.new(sub_unit_params)

    respond_to do |format|
      if @sub_unit.save
        format.html { redirect_to @sub_unit, notice: 'Sub unit was successfully created.' }
        format.json { render :show, status: :created, location: @sub_unit }
      else
        format.html { render :new }
        format.json { render json: @sub_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_units/1
  # PATCH/PUT /sub_units/1.json
  def update
    respond_to do |format|
      if @sub_unit.update(sub_unit_params)
        format.html { redirect_to @sub_unit, notice: 'Sub unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub_unit }
      else
        format.html { render :edit }
        format.json { render json: @sub_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_units/1
  # DELETE /sub_units/1.json
  def destroy
    @sub_unit.destroy
    respond_to do |format|
      format.html { redirect_to sub_units_url, notice: 'Sub unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_unit
      @sub_unit = SubUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_unit_params
      params.require(:sub_unit).permit(:name, :code, :unit_id, :grade)
    end
end
