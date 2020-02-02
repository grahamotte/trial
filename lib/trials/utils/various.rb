def secrets
  SECRETS
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
