class SubTeam < ApplicationRecord
  belongs_to :team
  has_many :employees
end