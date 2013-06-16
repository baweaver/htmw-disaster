require 'sqlite3'

class Responders

def dbCon
	db = SQLite3::Database.open "../db/development.sqlite3"
	return db
	end
	
def initailize
	db = dbCon
	db.execute('INSERT into RESPONDERS values (null,"null","null","null", "null","2","null","null")')
	db.close
end
	
def updatePhone(srcPhone="null")
	db = dbCon
	db.execute('INSERT into RESPONDERS values (null,' + srcPhone + ',"null","null","null","2","null","null")')
	db.close
	end

def updateZip(srcPhone="null", zip="null")
	db = dbCon
	db.execute('update RESPONDERS set ZIP=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM RESPONDERS WHERE SRCPHONE='+ srcPhone +')', zip)
	db.execute('update RESPONDERS set ACTIVE=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM RESPONDERS WHERE SRCPHONE='+ srcPhone +')', 3)
	db.close
end

def updateRadius(srcPhone="null", loc="null")
	db = dbCon
	db.execute('update RESPONDERS set RADIUS=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM RESPONDERS WHERE SRCPHONE='+ srcPhone +')', loc)
	db.execute('update RESPONDERS set ACTIVE=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM RESPONDERS WHERE SRCPHONE='+ srcPhone +')', 4)
	
	db.close
end

def updateCategory(srcPhone="null", category="null")
	db = dbCon
	db.execute('update RESPONDERS set CATEGORY=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM RESPONDERS WHERE SRCPHONE='+ srcPhone +')', category)
	db.execute('update RESPONDERS set ACTIVE=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM RESPONDERS WHERE SRCPHONE='+ srcPhone +')', 1)
	
	db.close
end

def updateActive(srcPhone="null", active="null")
	db = dbCon
	db.execute('update RESPONDERS set ACTIVE=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM RESPONDERS WHERE SRCPHONE='+ srcPhone +')', active)
	db.close
end

def updateCreatedDate(srcPhone="null", date="null")
	db = dbCon
	db.execute('update RESPONDERS set CREATED_DT=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM RESPONDERS WHERE SRCPHONE='+ srcPhone +')', date)
	db.close
end

def updateDate(srcPhone="null", date="null")
	db = dbCon
	db.execute('update RESPONDERS set UPDATED_DT=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM RESPONDERS WHERE SRCPHONE='+ srcPhone +')', date)
	db.close
end




end