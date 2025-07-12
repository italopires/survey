class Department < ApplicationRecord
  belongs_to :division
  has_many :teams
end
