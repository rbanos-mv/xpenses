class Expense < ApplicationRecord
  belongs_to :user
  has_many :records
  has_many :groups, through: :records

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
