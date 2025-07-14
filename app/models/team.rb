class Team < ApplicationRecord
  belongs_to :department
  has_many :sub_teams

  validates :name, :department_id, presence: true
end
