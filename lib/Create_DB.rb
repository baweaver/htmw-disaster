require 'sqlite3'

dbver="1.0.0"
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
	db.execute "insert into FONEFLARE (DBVERSION, LASTSMSQUERY) values ('" + dbver + "','1900-01-01 00:00:00')"
	
	db.execute "drop table if exists FLARES"
	db.execute "drop table if exists CATEGORIES"
	db.execute "drop table if exists RESPONDERS"
	db.execute "drop table if exists ASSISTS"
	db.execute "drop table if exists COMMUNICATIONS"

	dbver=db.get_first_value "select max(DBVERSION) from FONEFLARE limit 1"
	
	puts "Current database version is " + dbver
end

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

db.execute "create table if not exists RESPONDERS	(RESPONDER_ID INTEGER PRIMARY KEY,
														SRCPHONE TEXT, 
														CATEGORY INTEGER, 
														ZIP TEXT, 
														RADIUS INTEGER, 
														ACTIVE INTEGER,
														CREATED_DT TEXT,
														UPDATED_DT TEXT)"

db.execute "create table if not exists ASSISTS (ASSIST_ID INTEGER PRIMARY KEY,
												FLARE_ID INTEGER,
												RESPONDER_ID INTEGER,
												CREATED_DT TEXT)"

db.execute "create table if not exists COMMUNICATIONS	(COMMUNICATION_ID INTEGER PRIMARY KEY,
															FLARE_ID INTEGER,
															RESPONDER_ID INTEGER,
															CREATED_DT TEXT)"
														

