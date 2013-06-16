require 'rubygems' # This line not needed for ruby > 1.8
require 'twilio-ruby'
require 'sqlite3'

db = SQLite3::Database.open "../../db/development.sqlite3"
puts db.get_first_value "select sqlite_version()"

db.execute "create table if not exists flares (FLARE_ID Integer PRIMARY KEY, SRCPHONE TEXT, ZIP TEXT, LOCATION TEXT, LATTITUDE REAL, LONGITUTDE REAL, CATEGORY INTEGER, DESCRIPTION TEXT, ACTIVE INTEGER, CREATED_DT TEXT, UPDATED_DT TEXT)" 
db.execute "insert into flares (srcphone) values ('8166944335')"

rs=db.execute "select * from flares"

rs.each do |row|
	puts row.join "\s"
end
