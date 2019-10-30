def parse_json_file(filename)
  JSON
    .parse(read(filename))
    .deep_symbolize_keys
end
