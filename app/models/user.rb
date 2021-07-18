class User < ApplicationRecord
  has_many :recipes
  has_many :categories, through: :recipes
  has_many :comments
  has_many :commented_recipes, through: :comments, source: :recipe # The odin project, active record associations 
  has_secure_password # Authenticate, validate passowrd & password confirmation

  validates :email, presence: true, uniqueness: true 
end
