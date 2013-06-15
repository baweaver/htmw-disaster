class Flare < ActiveRecord::Base
  attr_accessible :active, :category, :description, :lat, :location, :long, :srcphone, :zip
end
