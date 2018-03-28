class Transmission < ApplicationRecord
  STATUS = %w[confirmed started done].freeze

  enum status: STATUS

  validates :name, presence: true
  validates :status, presence: true
end
