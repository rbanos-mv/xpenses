class Group < ApplicationRecord
  belongs_to :user
  has_many :records
  has_many :expenses, -> { order 'created_at DESC' }, through: :records

  validates :name, presence: true
  validates :icon, presence: true

  def all_records
    # implement
  end

  def count
    # implement
  end

  def total
    # implement
  end
end
