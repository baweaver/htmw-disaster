require 'sqlite3'

dbver="1.0.4"
db = SQLite3::Database.open "../db/development.sqlite3"

if "FONEFLARE"!=db.get_first_value("SELECT name FROM sqlite_master WHERE type='table' AND name='FONEFLARE'");
	db.execute "create table if not exists FONEFLARE (DBVERSION TEXT,
														LASTSMSQUERY TEXT)"
	db.execute "insert into FONEFLARE (DBVERSION, LASTSMSQUERY) values ('" + dbver + "','1900-01-01 00:00:00')"
	dbcurver=""
else
	dbcurver=db.get_first_value "select max(DBVERSION) from FONEFLARE limit 1"
end

if (dbcurver!=dbver)
	puts "Database version " + dbver + " is not current."
	puts "Dropping all tables and recreating."

	db.execute "delete from FONEFLARE"
	db.execute "insert into FONEFLARE (DBVERSION, LASTSMSQUERY) values ('" + dbver + "','1900-01-01 00:00:00 +0000')"
	
	db.execute "drop table if exists FLARES"
	db.execute "drop table if exists CATEGORIES"
	db.execute "drop table if exists RESPONDERS"
	db.execute "drop table if exists ASSISTS"
	db.execute "drop table if exists COMMUNICATIONS"
		
	puts "Current database version is " + dbver

	puts "Create FLARES table"
	db.execute "create table if not exists FLARES (FLARE_ID INTEGER PRIMARY KEY, 
													SRCPHONE TEXT, 
													ZIP TEXT, 
													LOCATION TEXT, 
													CATEGORY INTEGER, 
													DESCRIPTION TEXT, 
													ACTIVE INTEGER, 
													CREATED_DT TEXT,
													UPDATED_DT TEXT)" 

	db.execute "create table if not exists CATEGORIES (CATEGORY_ID INTEGER PRIMARY KEY, 
														DESCRIPTION TEXT)" 

	db.execute "insert into CATEGORIES (DESCRIPTION) values ('Missing Person')"
	db.execute "insert into CATEGORIES (DESCRIPTION) values ('Medical Assistance')"
	db.execute "insert into CATEGORIES (DESCRIPTION) values ('Stranded')"
	db.execute "insert into CATEGORIES (DESCRIPTION) values ('Property Damage')"
	db.execute "insert into CATEGORIES (DESCRIPTION) values ('Shelter')"

	puts "Categories Rows"
		rs=db.execute("select * from CATEGORIES")
		rs.each do |row|
			puts row.join "\s"
		end

	puts "Create RESPONDERS table"													
	db.execute "create table if not exists RESPONDERS	(RESPONDER_ID INTEGER PRIMARY KEY,
															SRCPHONE TEXT, 
															CATEGORY INTEGER, 
															ZIP TEXT, 
															RADIUS INTEGER, 
															ACTIVE INTEGER,
															CREATED_DT TEXT,
															UPDATED_DT TEXT)"

	puts "Create ASSISTS table"													
	db.execute "create table if not exists ASSISTS (ASSIST_ID INTEGER PRIMARY KEY,
													FLARE_ID INTEGER,
													RESPONDER_ID INTEGER,
													CREATED_DT TEXT)"

	puts "Create COMMUNICATIONS table"													
	db.execute "create table if not exists COMMUNICATIONS	(COMMUNICATION_ID INTEGER PRIMARY KEY,
																FLARE_ID INTEGER,
																RESPONDER_ID INTEGER,
																CREATED_DT TEXT)"
															

end
