class Group < ApplicationRecord
  belongs_to :user
  has_many :records
  has_many :expenses, -> { order 'created_at DESC' }, through: :records

  validates :name, presence: true
  validates :icon, presence: true

  def icon_and_name
    "#{icon} #{name}"
  end

  def total
    expenses.sum(:amount)
    # implement
  end

  def self.icon_list
    ['✈️', '🍔', '🛍️', '🥕', '💰', '💅', '🍹', '🎁', '🏥', '🏠', '🚋', '🚰']
  end
end
