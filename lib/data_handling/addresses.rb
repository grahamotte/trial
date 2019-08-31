# normal format <number> <STREET NAME>, <CITY>, <STATE> <postal>

def normalize_address(address)
  return if address.blank?

  cleaner_string = if address.respond_to?(:address1)
    "#{address.address1}, #{address.city}, #{address.state} #{address.postal_code}"
  else
    address
  end

  cleaner_string = cleaner_string.gsub('#', ' #').squish
  parsed = StreetAddress::US.parse(cleaner_string)

  return if parsed.blank?
  return if parsed.number.blank?
  return if parsed.street.blank?
  return if parsed.city.blank?
  return if parsed.state.blank?
  return if parsed.postal_code.blank?

  parsed.prefix = nil
  parsed.suffix = nil
  parsed.unit_prefix = nil
  parsed.unit = nil
  parsed.postal_code_ext = nil

  parsed.to_s.upcase
end

def parse_address(address_string)
  StreetAddress::US.parse(address_string)
end

def normalize_and_parse_address(address_string)
  StreetAddress::US.parse(normalize_address(address_string))
end
