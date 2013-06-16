class CategoriesController < ApplicationController
  def read
    db = SQLite3::Database.open "db/development.sqlite3"
    @categories = db.execute("SELECT * FROM CATEGORIES;")
  end
end
