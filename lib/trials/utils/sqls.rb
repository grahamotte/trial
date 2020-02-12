def db(db_name = nil)
  db_name ||= 'data.db'
  db = SQLite3::Database.new(tmp_path(db_name))
  db.results_as_hash = true
  db
end

def create_db(db_name = nil)
  db(db_name)
end

def get_db(db_name = nil)
  db(db_name)
end

def import_csv_into_db(db_name = 'data.db', table, csv)
  system("sqlite3 -csv #{tmp_path(db_name)} '.import #{seed_path(csv)} #{table}'")
end

def query_db(db_name = nil, query)
  db(db_name).execute(query).map(&:symbolize_keys)
end
