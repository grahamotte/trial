def render_table_from_hashes(hash_set, sort: true, headers: nil)
  return 'no data' if hash_set.blank?

  headers = headers || hash_set.to_harray.uniq_keys

  headers.sort! if sort

  content = hash_set
    .map { |h| h.select { |k, v| v.present? }.to_h }
    .map { |hash| headers.map { |h| hash.dig(h) } }
    .map { |r| r.map(&:to_s) }

  TTY::Table.new(header: headers, rows: content).render(:unicode).to_s
end

def log(item, nl: true, quiet: false, each: true)
  item ||= ''

  if each && item.is_a?(Array)
    item.each { |i| log(i, nl: nl, quiet: quiet, each: false) }
    return
  end

  File.open(result_path('log.txt'), 'a') do |f|
    f << begin
      if item.is_a?(String) || item.is_a?(Numeric)
        item.to_s
      else
        PP.pp(item, '').chomp
      end
    end

    f << "\n" if nl
  end

  print item unless quiet
  puts '' if nl
end

def l(item, nl: true, quiet: false)
  log(item, nl: nl, quiet: quiet, each: false)
end
