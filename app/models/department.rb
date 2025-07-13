class Department < ApplicationRecord
  belongs_to :division
  has_many :teams

  validates :name, :division_id, presence: true
end
