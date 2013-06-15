class Responder < ActiveRecord::Base
  attr_accessible :active, :lat, :long, :radius, :srcphone, :zip
end
