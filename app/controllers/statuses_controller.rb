class StatusesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :create
  # GET /statuses
  # GET /statuses.json
  def index
    @statuses = Status.all
  end

  # GET /statuses/1
  # GET /statuses/1.json
  #def show
  #  @status = Status.find(params[:id])
  #end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = Status.new(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to @status, notice: 'Status was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:temperature, :air_humidity, :carbon_monoxide, :health_status, :collected_at, :device_id)
    end
end
