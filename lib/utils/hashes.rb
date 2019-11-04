def uniq_hash_keys(hashes)
  hashes.flat_map(&:keys).uniq.compact
end

def parse_key(hash, key, type, date_format: '%Y-%m-%d')
  val = hash.dig(key)

  new_val = or_nil do
    case type
    when :date
      Date.strptime(val, date_format)
    when :datetime
      DateTime.parse(val)
    when :integer, :int
      val.to_i
    when :float
      val.to_f
    when :string
      val.to_s
    when :alphanum
      string_to_alphanum(val)
    end
  end

  hash.merge(key => new_val)
end

def parse_keys(hash, schema = {})
  schema.each do |key, type|
    next unless hash.key?(key)
    hash = parse_key(hash, key, type)
  end

  hash
end

def count_for_group_by(batch, &block)
  batch
    .group_by(&block)
    .map { |k, v| [k, v.length] }
    .to_h
end

def array_to_count_hash(list)
  list.uniq.reduce({}) do |h, i|
    h[i] = list.count(i)
    h
  end
end

def update_counts_hash(counts, update)
  update.each do |k, v|
    if counts.key?(k)
      counts[k] += v
    else
      counts[k] = v
    end
  end

  counts
end
