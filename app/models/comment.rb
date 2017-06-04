class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :journey
  
  validates :body, :presence => true
end
