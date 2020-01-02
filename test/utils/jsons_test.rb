require 'test_helper'

class JsonsTest < UnitTest
  def test_read_json
    assert_equal parsed_json, read_json('json_file.json')
  end

  def test_json_cache
    actual = json_cache('cache_key') { read_json('json_file.json') }
    assert_equal parsed_json, actual
    assert_equal parsed_json, json_cache('cache_key') { 1 }
    invalidate_json_cache
    assert_equal 1, json_cache('cache_key') { 1 }
  end

  private

  def parsed_json
    [
      {
        :"1"=>"one",
        :"  a  " => "ayyee",
        nesting:[{ something: ["deeper"] }]
      },
      1,
      10,
      100.1,
      { lastly:42 },
    ]
  end
end
