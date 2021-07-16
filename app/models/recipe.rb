class Recipe < ApplicationRecord
  belongs_to :user # Macro gives us two methods, writer & reader
  belongs_to :category
  has_many :comments
  has_many :users, through: :comments # Gives us the writer method for the plural 
  validates :username, :instructions, :ingredients, presence: true
 
  scope :alpha, -> { order(:name) }

  def self.search(params)
    left_joins(:comments).where("LOWER(recipes.name) LIKE :term OR LOWER(recipes.ingredient) LIKE :term", term: "%#{params}%")
    #select any recipe where the name or ingredients closely match search 
  end

  #accepts_nested_attributes_for :categories --this macro doesnt work when has_many
  def category_attributes=(attr) # Necessary to define yourself when we have a has_many
    self.category = Category.find_or_create_by(attr) if !attr[:name].blank?
  end
end
