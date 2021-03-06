class DevicesController < ApplicationController
  before_action :authenticate_admin!, except: :create
  skip_before_action :verify_authenticity_token, only: :create

  before_action :set_device, only: :show

  # GET /devices
  # GET /devices.json
  def index
    serial_number = params[:serial_number]
    if serial_number.present?
      @devices = Device.where('serial_number LIKE ?', "%#{serial_number}%")
    else
      @devices = Device.all
    end
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
    time_range = params[:time_range]
    today = Date.today
    case(time_range)
      when 'YEAR'
        @min_date = today.beginning_of_year
        @max_date = today.end_of_year
      when 'MONTH'
        @min_date = today.beginning_of_month
        @max_date = today.end_of_month
      when 'WEEK'
        @min_date = today.beginning_of_week
        @max_date = today.end_of_week
      else
        @min_date = today.beginning_of_day
        @max_date = today.end_of_day
    end
    @statuses = @device.statuses.where(collected_at: @min_date..@max_date)
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render :show, status: :created, location: @device }
      else
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:serial_number, :firmware_version, :token)
    end
end
