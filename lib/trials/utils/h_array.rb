class HArray < Array
  def hashes
    self
  end

  def count_by
    hashes
      .group_by { |x| yield(x) }
      .map { |k, v| [k, v.length] }
      .to_h
  end

  def rename_keys(**renames)
    renames.each do |orig_key, new_key|
      hashes.map do |h|
        new_h = h.dup
        new_h[new_key] = new_h.delete(orig_key)
        new_h
      end
    end
  end

  def normalize_keys
    hashes.map do |h|
      h
        .map { |k, v| [normalize_key(k), v] }
        .to_h
    end
  end

  def uniq_keys
    hashes.flat_map(&:keys).uniq.compact
  end

  def merge(*groups, key:, join: :inner)
    groups = [self, *groups].map do |group|
      group
        .map { |h| [h.dig(key), h] }
        .to_h
    end

    keys = begin
      case join
      when :inner
        groups.map(&:keys).reduce(&:&)
      when :all
        groups.flat_map(&:keys).uniq
      when :first
        groups.first.keys
      end
    end

    keys.map do |key|
      groups
        .map { |g| g.dig(key) }
        .compact
        .reduce(&:merge)
    end
  end

  private

  def normalize_key(k)
    k.downcase.to_sym
  end
end
