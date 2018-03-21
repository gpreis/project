class Account < ApplicationRecord
  # DeviseTokenAuths modules and concern
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  TYPES = %w(User Admin).freeze

  validates :type,     presence: true, inclusion: { in: TYPES }
  validates :name,     presence: true
  validates :nickname, presence: true
  validates :uid,      presence: true
  validates :provider, presence: true
end

class User < Account; end
class Admin < Account; end
