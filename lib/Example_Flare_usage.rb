require './flare'
require 'time'

new = Flare.new
new.updatePhone("8164469483")
new.updateZip("8164469483", "64152")
new.updateLocation("8164469483", "Between Sioux Drive and Parkville Ave")

new.updateCategory("8164469483", "5")
new.updateDescription("8164469483", "Tree fell on my house")
t = Time.now
tt = Time.parse(t.to_s)
new.updateCreatedDate("8164469483", tt.to_s)
new.updateDate("8164469483", tt.to_s)