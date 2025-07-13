class Team < ApplicationRecord
  belongs_to :department
  has_many :sub_areas

  validates :name, :department_id, presence: true
end
