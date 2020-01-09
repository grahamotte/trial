def uniq_hash_keys(hashes)
  hashes.flat_map(&:keys).uniq.compact
end

def sanitize_hash_value(hash, key:, type:, date_format: '%Y-%m-%d')
  hash.merge(
    key => or_nil do
      case type
      when :date
        Date.strptime(hash.dig(key), date_format)
      when :datetime
        DateTime.parse(hash.dig(key))
      when :integer, :int
        hash.dig(key).to_i
      when :float
        hash.dig(key).to_f
      when :string
        hash.dig(key).to_s
      when :alphanum
        string_to_alphanum(hash.dig(key))
      when :present?
        hash.dig(key).present?
      end
    end
  )
end

def sanitize_hash_values(hash, scheme = {})
  scheme.each do |k, v|
    hash = sanitize_hash_value(hash, key: k, type: v)
  end

  hash
end

def rename_hash_key(hash, from:, to:)
  hash[to] = hash.delete(from)
  hash
end

def rename_hash_keys(hash, scheme = {})
  scheme.each do |k, v|
    hash = rename_hash_key(hash, from: k, to: v)
  end

  hash
end

def merge_hash_groups(*groups, key:, join_type: :inner)
  groups = groups.map { |group| group.map { |g| [g.dig(key), g] }.to_h }

  keys = begin
    case join_type
    when :inner
      groups.map(&:keys).reduce(&:&)
    when :all
      groups.flat_map(&:keys).uniq
    when :first
      groups.first.keys
    end
  end

  keys.map { |key| groups.map { |g| g.dig(key) }.compact.reduce(&:merge) }
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
