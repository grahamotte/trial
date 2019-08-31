def hashes_to_sql_temp_table(hashes)
  attrs = uniq_hash_keys(hashes)

  attr_chars = attrs
    .map { |a| "#{a} varchar" }
    .join(', ')

  value_tuples = hashes
    .map { |s| '(' + attrs.map { |a| "'#{s.dig(a) }'" }.join(', ') + ')' }
    .join(",\n")

  <<~SQL
    create temp table seed_data (
      #{attr_chars}
    );

    insert into seed_data values
    #{value_tuples};
  SQL
end

def create_db(name)
  db_loc = results_path("#{name}.db")

  raise 'db already exists' if File.exist?(db_loc)

  db = SQLite3::Database.new(db_loc)
  db.results_as_hash = true
  db
end

def use_db(name)
  db_loc = seeds_path("#{name}.db")

  raise 'no db exists' unless File.exist?(db_loc)

  db = SQLite3::Database.new(db_loc)
  db.results_as_hash = true
  db
end

def create_table(db, table, **attrs)
  should_log = attrs.delete(:log)
  attrs = attrs.map { |k, v| "  #{k} #{v}" }.join(",\n")
  sql = <<~SQL
    create table #{table} (
    #{attrs}
    );
  SQL

  log sql if should_log
  db.execute sql
end

def insert_into_db(db, table, **attrs)
  should_log = attrs.delete(:log)
  keys_group = "(#{attrs.keys.join(', ')})"
  values_group = "(#{(['?'] * attrs.values.length).join(', ')})"
  sql = <<~SQL
    insert into #{table} #{keys_group}
    values #{values_group}
  SQL

  log sql if should_log
  db.execute sql, attrs.values
end

def query_db(db, query)
  db.execute(query)
end
