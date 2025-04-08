class Organization < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  
  has_one :token, dependent: :destroy
end