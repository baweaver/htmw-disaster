require 'sqlite3'
require 'time'

class Communication

def dbCon
	db = SQLite3::Database.open "../db/development.sqlite3"
	return db
	end
	
def initailize

end
	
def updateCommunication(flare_ID="null")
	db = dbCon
	t = Time.now
	tt = Time.parse(t.to_s)
	db.execute('INSERT into ASSISTS values (null,'+ flare_ID +',null,'+ tt +')')
	db.close
	end

def updateResponder(flare_ID="null", responder_ID="null")
	db = dbCon
	db.execute('update ASSISTS set RESPONDER_ID=? WHERE FLARE_ID='+ flare_ID +')', responder_ID)
	db.close
end




end