class Seat < ApplicationRecord
  validates :user_id, :uniqueness => { :scope => [:journey_id], :message => "already has a seat" }
  belongs_to :user
  belongs_to :journey
end
