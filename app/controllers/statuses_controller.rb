class StatusesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create, :bulk_create]

  before_action :set_device, only: [:create, :index]
  before_action :set_token, only: [:create, :bulk_create]

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

  def bulk_create
    @device = Device.find(bulk_params[:device_id])
    verify_device_token
    statuses = bulk_params[:statuses]
    sent_count = statuses.count
    created_count = 0
    statuses.each do |status|
      created_count += 1 if @device.statuses.create(status)
    end
    render json: { statuses_sent: sent_count, statuses_created: created_count }
  end

  private
    def set_device
      @device = Device.find(status_params[:device_id])
    end

    def set_token
      @token = request.headers['Authorization'].split(' ').last
    end

    def verify_device_token
      return head(:unauthorized) unless @device.token == @token
    end

    def bulk_params
      params.permit(:device_id, statuses: [:temperature, :air_humidity, :carbon_monoxide, :health_status, :collected_at])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:temperature, :air_humidity, :carbon_monoxide, :health_status, :collected_at, :device_id)
    end
end
