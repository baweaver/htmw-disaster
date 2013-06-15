class Commmunication < ActiveRecord::Base
  attr_accessible :flare_id, :responder_id
  belongs_to :responder
  belongs_to :flare
end
