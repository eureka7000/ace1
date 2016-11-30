class ConceptExerciseSolutionLinksController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_concept_exercise_solution_link, only: [:update, :destroy]

  def create
    @concept_exercise_solution_link = ConceptExerciseSolutionLink.new(concept_exercise_solution_link_params)

    ret = { status: 'ok' }

    if @concept_exercise_solution_link.save
      render json: ret
    end

  end

  def update
    ret = { status: 'ok' }

    if @concept_exercise_solution_link.update(concept_exercise_solution_link_params)
      render json: ret
    end
  end

  def destroy
    @concept_exercise_solution_link.destroy
    ret = { status: 'ok' }
    render json: ret
  end

  private

  def set_concept_exercise_solution_link
    @concept_exercise_solution_link = ConceptExerciseSolutionLink.find(params[:id])
  end

  def concept_exercise_solution_link_params
    params.require(:concept_exercise_solution_link).permit(:concept_exercise_id, :unit_concept_linked_id)
  end
end
