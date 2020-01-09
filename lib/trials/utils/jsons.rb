def read_json(filename)
  result = JSON.parse(read(filename))

  aggressive_deep_symbolize_keys(result)
end

def write_hashes_to_json(file, hashes)
  write(file, hashes.to_json)
end

def json_cache(key)
  name = "json/#{key}.json"

  return aggressive_deep_symbolize_keys(JSON.parse(read_tmp(name))) if tmp_exists?(name)

  write_tmp(name, yield.to_json)
  json_cache(key)
end

def invalidate_json_cache
  delete_tmp("json")
end
