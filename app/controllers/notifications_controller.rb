class NotificationsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_notification, only: [:show, :destroy]

  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = Notification.active
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    respond_to do |format|
      if @notification.update(dismissed: true)
        format.html { redirect_to notifications_url, notice: 'Notification was successfully dismissed.' }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require(:notification).permit(:level, :status, :dismissed)
    end
end
