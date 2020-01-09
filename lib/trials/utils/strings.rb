def normalize_string(string)
  string.chomp.strip.squish
end

def string_to_alphanum(string)
  string.gsub(/[^A-Za-z0-9]/, '')
end

def string_encode_utf_8(string)
  string.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
end
