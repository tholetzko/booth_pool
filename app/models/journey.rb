class Journey < ApplicationRecord

  belongs_to :organizer, :class_name => "User"
  has_many :comments, :dependent => :destroy
  has_many :seats, :dependent => :destroy
  has_many :users, :through => :seats

  validates :origin, :presence => true
  validates :destination, :presence => true
  validates :date, :presence => true
  validates :capacity, :presence => true
  validates :capacity, :numericality => { :less_than_or_equal_to => 6, :greater_than_or_equal_to => 0 }
end
