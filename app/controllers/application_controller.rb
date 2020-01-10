class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_notifications_stats

  protected

  def set_notifications_stats
    return unless admin_signed_in?
    @warning_count = Notification.active.warning.count
    @danger_count = Notification.active.danger.count
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:first_name, :last_name])
  end

  def after_invite_path_for(inviter, invitee)
    admins_path
  end
end
