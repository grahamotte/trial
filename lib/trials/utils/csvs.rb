def read_csv(filename)
  CSV
    .foreach(seeds_path(filename), headers: true)
    .map(&:to_h)
    .map(&:symbolize_keys)
    .select { |i| i.values.any?(&:present?) }
end

def write_csv_from_hashes(file, hash_set, attrs: nil)
  attrs ||= uniq_hash_keys(hash_set)

  CSV.open(results_path(file), 'w') do |csv|
    csv << attrs

    hash_set.each do |c|
      csv << attrs.map { |a| c.send(:dig, a) }
    end
  end
end
