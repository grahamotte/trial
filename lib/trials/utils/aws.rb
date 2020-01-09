def ddb_connection
  @connection ||= Aws::DynamoDB::Client.new(
    access_key_id: secrets.aws.key,
    secret_access_key: secrets.aws.secret,
    region: secrets.aws.region,
  )
end

def cached_ddb_scan(query)
  json_cache(query.dig(:table_name)) { ddb_scan(query) }
end

def ddb_scan(query)
  segmentation = query.delete(:segmentation) || 4

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

    result = ddb_connection.scan(query.merge(exclusive_start_key: result&.last_evaluated_key))
    items += result.items.compact.map(&:symbolize_keys)
  end

  items
end

def ddb_upload_items(table, all_items)
  all_items.each_slice(25).with_index do |items, i|
    next unless items.any?

    begin
      ddb_connection.batch_write_item(
        request_items: {
          table => items.compact.map do |item|
            {
              put_request: {
                item: item
              }
            }
          end
        }
      )
    end

    yield(items, i * 25) if block_given?
  end
end
