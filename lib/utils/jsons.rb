def parse_json_file(filename)
  result = JSON.parse(read(filename))

  return result.map(&:deep_symbolize_keys) if result.is_a?(Array)

  result.deep_symbolize_keys
end

def write_hashes_to_json(file, hashes)
  write(file, hashes.to_json)
end
