# normal <FIRST> <LAST>

Name = Struct.new(:first_name, :middle_name, :last_name)

class NamePartsParser
  def initialize(name_string)
    @namae = Namae.parse((name_string || '').upcase).first
  end

  def first
    normalize_name(split_first_and_middle(given).first)
  end

  def middle
    normalize_name(split_first_and_middle(given).last)
  end

  def last
    normalize_name(family)
  end

  private

  def given
    @namae&.given || ''
  end

  def family
    @namae&.family || ''
  end

  def split_first_and_middle(first_and_middle)
    names = first_and_middle.split(' ', 2)
    names.length == 1 ? names + [''] : names
  end
end

def normalize_name(name)
  return if name.blank?

  name = name_from_parts(name) if name.respond_to?(:first_name)

  name.strip.upcase.delete('^A-Z\ \-').squeeze(" ")
end

def normalize_full_names(names)
  Array.wrap(names)
    .map { |n| normalize_full_name(n) }
    .map(&:to_s)
    .map(&:presence)
    .compact
    .uniq
end

def normalize_full_name(name)
  return if name.blank?

  name.strip.upcase.delete('^A-Z\ \-').squeeze(" ")
end

def parse_name(name)
  NamePartsParser.new(name)
end

def normalize_and_parse_name(name)
  NamePartsParser.new(normalize_name(name))
end

# private

def name_from_parts(name)
  first = normalize_name_part(name.first_name)
  last = normalize_name_part(name.last_name)

  [first, last].join(' ')
end

def full_name_from_parts(name)
  first = normalize_name_part(name.first_name)
  middle = normalize_name_part(name.middle_name)
  last = normalize_name_part(name.last_name)

  [first, middle, last].join(' ')
end
