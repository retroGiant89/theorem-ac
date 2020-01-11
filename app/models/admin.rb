class Admin < ApplicationRecord
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :validatable, :trackable

  def full_name
    [first_name, last_name].join
  end

  def active_for_authentication?
    super && !locked
  end
end
