class Recipe < ApplicationRecord
  belongs_to :user 
  belongs_to :category
  has_many :comments
  has_many :users, through: :comments 
  validates :name, :instructions, :ingredients, presence: true
 
  scope :alpha, -> { order(:name) }

  def self.search(params)
    left_joins(:category).where("LOWER(recipes.name) LIKE :term OR LOWER(recipes.ingredients) LIKE :term", term: "%#{params}%")
    #select any recipe where the name or ingredients closely match search 
  end

  #accepts_nested_attributes_for :categories --this macro doesnt work when has_many
  def category_attributes=(attr) # Necessary to define yourself when we have a has_many
    self.category = Category.find_or_create_by(attr) if !attr[:name].blank?
  end
end
