class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe    

  validates :content, presence: true 
  validates :recipe, uniqueness: true
end
