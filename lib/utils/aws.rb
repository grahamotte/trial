def ddb_scan(query)
  segmentation = query.delete(:segmentation) || 1

  threads = (0..segmentation - 1).map do |segment|
    Thread.new do
      Thread.current[:output] = ddb_scan_without_segmentation(
        query.merge(
          total_segments: segmentation,
          segment: segment,
        ),
      )
    end
  end

  threads.each(&:join)

  threads.map { |t| t[:output] }.flatten
end

def ddb_scan_without_segmentation(query)
  result = nil
  requests = 0
  items = []

  loop do
    break unless result.blank? || result.last_evaluated_key.present?

    result = connection.scan(query.merge(exclusive_start_key: result&.last_evaluated_key))
    items += result.items.compact.map(&:symbolize_keys)
  end

  items
end
