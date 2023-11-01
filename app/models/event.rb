class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_and_belongs_to_many :attendees, class_name: 'User'

  scope :past, -> { where("time <= ?", Time.now) }
  scope :upcoming, -> { where("time > ?", Time.now) }
end
