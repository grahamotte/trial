l list_dir('pdfs')

log list_dir('pdfs')
  .last
  .then { |x| pdf_to_text(x) }
  .split("\n")
  .first(5)

log 'test.csv'
  .then { |x| seeds_path(x) }
  .then { |x| parse_csv_file(x) }
  .then { |x| x.map { |h| parse_key(h, :wow, :float) } }
  .then { |x| x.map { |h| parse_key(h, :lol, :date) } }
  .then { |x| x.map { |h| parse_key(h, :something_longer, :alphanum) } }
  .then { |x| tablize_hash_set(x) }

write(
  'out.sql',
  'test.csv'
    .then { |x| seeds_path(x) }
    .then { |x| parse_csv_file(x) }
    .then { |x| hashes_to_sql_temp_table(x) },
)

'test.csv'
  .then { |x| seeds_path(x) }
  .then { |x| parse_csv_file(x) }
  .then { |x| write_hashes_to_csv('out.csv', x) }

log 'test string'
log 100
log nil
log nil
log 11.22
log(a: 'butt')
log [1, 'a', { c: :d }]

log [1,1,1,2,2,0,99,99,99,100]
  .then { |x| array_to_count_hash(x) }
  .then { |x| update_counts_hash(x, 99 => 99) }

timeit { sleep 1 }

timeit do
  log readlines('addresses.txt')
    .map { |a| normalize_and_parse_address(a) }
    .compact
    .map { |a| [a.number, a.street, a.street_type, a.city, a.state, a.postal_code] }
    .map { |a| %w[num street type city state zip].zip(a).to_h }
    .uniq
    .then { |x| tablize_hash_set(x, sort: false) }
end

log readlines('names.txt')
  .map { |n| normalize_and_parse_name(n) }
  .map { |n| [n.first, n.middle, n.last] }
  .map { |a| %w[first middle last].zip(a).to_h }
  .then { |x| tablize_hash_set(x, sort: false) }

db = create_db('pii')

create_table(
  db,
  'names',
  first_name: 'varchar(30)',
  middle_name: 'varchar(30)',
  last_name: 'varchar(30)',
)

readlines('names.txt')
  .map { |n| normalize_and_parse_name(n) }
  .map do |n|
    insert_into_db(
      db,
      'names',
      first_name: n.first,
      middle_name: n.middle,
      last_name: n.last,
    )
  end

log query_db(db, "select * from names")
  .then { |x| tablize_hash_set(x, sort: false) }
