def hash_from_xml(str)
  Hash.from_xml(clean_xml(str)).deep_symbolize_keys
end

def prettify_xml(str)
  Nokogiri::XML(str) { |c| c.default_xml.noblanks }.to_xml(indent: 2)
end

def clean_xml(str)
  Nokogiri::XML(str.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')).to_xml
end
