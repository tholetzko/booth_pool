class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_many :comments, :dependent => :destroy
  has_many :journeys, :foreign_key => "organizer_id", :dependent => :destroy
  has_many :seats, :dependent => :destroy
end
