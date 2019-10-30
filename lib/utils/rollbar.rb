def get_single_rollbar_items_page(token:, page:, status: 'active')
  url = URI("https://api.rollbar.com/api/1/instances/?access_token=#{token}&page=#{page}&status=#{status}")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(url)
  JSON.parse(http.request(request).body).deep_symbolize_keys.dig(:result, :instances)
end

def get_rollbar_items(token:, status: 'active')
  current_page = 0
  items = []

  loop do
    single_page_of_items = get_single_rollbar_items_page(token: token, page: current_page, status: status)

    items += single_page_of_items

    break if single_page_of_items.empty?
    break if yield(current_page, items)

    current_page += 1
  end

  items.compact.uniq
end
