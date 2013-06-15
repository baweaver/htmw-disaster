class Assist < ActiveRecord::Base
  attr_accessible :active, :flare_id, :responder_id
  belongs_to :flare
  belongs_to :responder
end
