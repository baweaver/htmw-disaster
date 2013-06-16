require 'sqlite3'

class Flare

def dbCon
	db = SQLite3::Database.open "../db/development.sqlite3"
	return db
	end
	
def initailize
	db = dbCon
	db.execute('INSERT into FLARES values (null,"null","null","null", "null","null","2","null","null")')
	db.close
end
	
def updatePhone(srcPhone="null")
	db = dbCon
	db.execute('INSERT into FLARES values (null,' + srcPhone + ',"null","null", "null","null","2","null","null")')
	db.close
	end

def updateZip(srcPhone="null", zip="null")
	db = dbCon
	db.execute('update FLARES set ZIP=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM FLARES WHERE SRCPHONE='+ srcPhone +')', zip)
	db.execute('update FLARES set ACTIVE=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM FLARES WHERE SRCPHONE='+ srcPhone +')', 3)
	db.close
end

def updateLocation(srcPhone="null", loc="null")
	db = dbCon
	db.execute('update FLARES set LOCATION=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM FLARES WHERE SRCPHONE='+ srcPhone +')', loc)
	db.execute('update FLARES set ACTIVE=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM FLARES WHERE SRCPHONE='+ srcPhone +')', 4)
	db.close
end

def updateCategory(srcPhone="null", category="null")
	db = dbCon
	db.execute('update FLARES set CATEGORY=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM FLARES WHERE SRCPHONE='+ srcPhone +')', category)
	db.execute('update FLARES set ACTIVE=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM FLARES WHERE SRCPHONE='+ srcPhone +')', 5)
	db.close
end

def updateDescription(srcPhone="null", description="null")
	db = dbCon
	db.execute('update FLARES set DESCRIPTION=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM FLARES WHERE SRCPHONE='+ srcPhone +')', description)
	db.execute('update FLARES set ACTIVE=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM FLARES WHERE SRCPHONE='+ srcPhone +')', 1)
	db.close
end

def updateActive(srcPhone="null", active="null")
	db = dbCon
	db.execute('update FLARES set ACTIVE=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM FLARES WHERE SRCPHONE='+ srcPhone +')', active)
	db.close
end

def updateCreatedDate(srcPhone="null", date="null")
	db = dbCon
	db.execute('update FLARES set CREATED_DT=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM FLARES WHERE SRCPHONE='+ srcPhone +')', date)
	db.close
end

def updateDate(srcPhone="null", date="null")
	db = dbCon
	db.execute('update FLARES set UPDATED_DT=? WHERE FLARE_ID=(SELECT MAX(FLARE_ID) FROM FLARES WHERE SRCPHONE='+ srcPhone +')', date)
	db.close
end




end