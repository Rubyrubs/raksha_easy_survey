class ComponentsController < ApplicationController
  def create
    @survey = Survey.find(params[:survey_id])
    @component = @survey.components.new(component_params)
    if @component.save
      render json: @component
    else
      render json: @component.errors, status: :unprocessable_entity
    end
  end

  def update
    @component = Component.find(params[:id])
    if @component.update(component_params)
      render json: @component
    else
      render json: @component.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @component = Component.find(params[:id])
    @component.destroy
    head :no_content
  end

  private

  def component_params
    params.require(:component).permit(:component_type, :content, :position_x, :position_y)
  end
end
