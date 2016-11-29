class UnitConceptDescSolutionLinksController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_unit_concept_desc_solution_link, only: [:update, :destroy]

  def create

    @unit_concept_desc_solution_link = UnitConceptDescSolutionLink.new(unit_concept_desc_solution_link_params)

    ret = { status: 'ok' }

    if @unit_concept_desc_solution_link.save
      render json: ret
    end

  end

  def update

    ret = { status: 'ok' }

    if @unit_concept_desc_solution_link.update(unit_concept_desc_solution_link_params)
      render json: ret
    end

  end

  def destroy
    @unit_concept_desc_solution_link.destroy
    ret = { status: 'ok' }
    render json: ret
  end


  private

  def set_unit_concept_desc_solution_link
    @unit_concept_desc_solution_link = UnitConceptDescSolutionLink.find(params[:id])
  end

  def unit_concept_desc_solution_link_params
    params.require(:unit_concept_desc_solution_link).permit(:unit_concept_desc_id, :unit_concept_linked_id)
  end
end
