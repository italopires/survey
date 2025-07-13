class SubTeam < ApplicationRecord
  belongs_to :team
  has_many :employees

  validates :name, :team_id, presence: true
end
