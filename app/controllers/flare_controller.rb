require "twilio-ruby"

class FlareController < ApplicationController
  ACCOUNT_SID = ''
  ACCOUNT_TOKEN = ''

  BASE_URL = ""

  CALLER_ID = ''  

  def index
  end
  
  def help
  end

  def new
  end

  def create
    db = SQLite3::Database.open "db/development.sqlite3"
    @categories = db.execute("SELECT * FROM CATEGORIES;")
  end

  def destroy
  end

  def call
  end

  def cancel
  end

  def respond
  end
end
