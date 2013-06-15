class Flare < ActiveRecord::Base
  attr_accessible :active, :category, :description, :lat, :location, :long, :srcphone, :zip
  has_many :communications
  has_many :assists
end
