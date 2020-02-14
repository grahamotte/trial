def secrets
  SECRETS
end

def run
  RUN
end

def root_path
  ROOT
end

def or_nil
  val = yield
  raise if val.blank?
  val
rescue StandardError
end

def float?(string)
  true if Float(string) rescue false
end

def float_or_nil(thing)
  Float(thing)
rescue StandardError
  nil
end

def aggressive_deep_symbolize_keys(maybe)
  return maybe.deep_symbolize_keys if maybe.respond_to?(:deep_symbolize_keys)
  return maybe.map { |i| aggressive_deep_symbolize_keys(i) } if maybe.respond_to?(:each)

  maybe
end

def marshal_fetch(key)
  return Marshal.load(read_cache(key)) if cache_exists?(key)

  File.open(cache_path(key), 'wb') do |f|
    f.write(Marshal.dump(yield))
  end

  marshal_fetch(key)
end
