def read_csv(filename)
  CSV
    .foreach(seed_path(filename), headers: true)
    .map(&:to_h)
    .map(&:symbolize_keys)
    .select { |i| i.values.any?(&:present?) }
end

def write_csv_from_hashes(file, hash_set, attrs: nil)
  attrs ||= hash_set.to_harray.uniq_keys

  CSV.open(result_path(file), 'w') do |csv|
    csv << attrs

    hash_set.each do |c|
      csv << attrs.map { |a| c.send(:dig, a) }
    end
  end
end
