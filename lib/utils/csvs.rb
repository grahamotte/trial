def parse_csv_file(filename)
  CSV
    .foreach(filename, headers: true)
    .map(&:to_h)
    .map(&:symbolize_keys)
end

def write_hashes_to_csv(file, set, attrs: nil)
  attrs ||= uniq_hash_keys(set)

  CSV.open(results_path(file), 'w') do |csv|
    csv << attrs

    set.each do |c|
      csv << attrs.map { |a| c.send(:dig, a) }
    end
  end
end
