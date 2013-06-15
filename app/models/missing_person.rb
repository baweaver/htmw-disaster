class MissingPerson < ActiveRecord::Base
  attr_accessible :contact_name, :contact_number, :description, :found, :name
end
