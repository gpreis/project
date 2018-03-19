class Account < ApplicationRecord
  # DeviseTokenAuths modules and concern
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
end
