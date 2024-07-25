# app/controllers/surveys_controller.rb
class SurveysController < ApplicationController
  # Ensures that the CSRF token is not required for the save_component action
  protect_from_forgery except: :save_component
  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      redirect_to edit_survey_path(@survey), notice: 'Survey was successfully created.'
    else
      render :new
    end
  end

  def edit
    @survey = Survey.find(params[:id])
    # You can use @survey to pre-load any data needed for editing
  end

  # POST /surveys/save_component
   def save_component
    
    component_params = params.require(:component).permit(:component_type, :content, :position_x, :position_y, :survey_id)

    # Ensure survey_id is present
    if component_params[:survey_id].present?
      # Find or initialize the component with the provided survey_id
      component = Component.find_or_initialize_by(
        component_type: component_params[:component_type],
        content: component_params[:content],
        position_x: component_params[:position_x],
        position_y: component_params[:position_y],
        survey_id: component_params[:survey_id] # Associate with survey
      )

      if component.save
        render json: { success: true, component: component }, status: :ok
      else
        render json: { success: false, errors: component.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { success: false, error: 'Survey ID is missing' }, status: :unprocessable_entity
    end
  end
  private

  # Strong parameters for creating or updating surveys, if needed
  def survey_params
    params.require(:survey).permit(:name, :description)
  end
end
