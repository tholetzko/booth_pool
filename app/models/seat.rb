class Seat < ApplicationRecord
  validates :user, :uniqueness => { :scope => [:journey_id], :message => "already has a seat" }
  belongs_to :user
  belongs_to :journey
end
