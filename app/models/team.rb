class Team < ApplicationRecord
  belongs_to :department
  has_many :sub_areas
end
