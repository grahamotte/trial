def parse_json_file(filename)
  JSON
    .parse(File.read(filename))
    .deep_symbolize_keys
end
