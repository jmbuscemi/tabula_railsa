class HomeController < ApplicationController
  before_action :check_session, only: [:show, :create]

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.save
        session[:survey_id] = @survey.id
        format.html { redirect_to home_path(@survey), notice: 'Survey was successfully created.' }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @survey = Survey.find(params[:id])
  end


  private
    def survey_params
      params.require(:survey).permit(:name, :chocolate, :rainbow, :puppies, :cash)
    end

    def check_session
      unless session[:survey_id] == nil
        flash.now[:notice] = "You have already submitted a survey"
        redirect_to root_path
      end
    end

end
