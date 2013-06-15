class Responder < ActiveRecord::Base
  attr_accessible :active, :lat, :long, :radius, :srcphone, :zip
  has_many :communications
  has_many :assists
end
