class StatusesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :create

  before_action :set_device, only: [:create, :index]

  before_action :verify_device_token, only: :create

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
    def set_device
      @device = Device.find(status_params[:device_id])
    end

    def verify_device_token
      logger = Rails.logger
      #logger.warn request.headers.to_json
      token = request.headers['Authorization'].split(' ').last
      logger.warn "WTF #{token}, #{@device.token}"

      return head(:unauthorized) unless @device.token == token
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:temperature, :air_humidity, :carbon_monoxide, :health_status, :collected_at, :device_id)
    end
end
