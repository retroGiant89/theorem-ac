class Admin < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  def full_name
    [first_name, last_name].join
  end
end
