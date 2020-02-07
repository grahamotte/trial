require 'test_helper'

class HashTest < UnitTest
  def test_sanitize_value
    # failures
    assert_nil ({ x: [] }).sanitize_value(:x, :float).dig(:x)

    # floats
    assert_equal 1, ({ x: 1 }).sanitize_value(:x, :float).dig(:x)
    assert_equal 1, ({ x: '1' }).sanitize_value(:x, :float).dig(:x)
    assert_equal 1.1, ({ x: '1.1' }).sanitize_value(:x, :float).dig(:x)
    assert_equal 0, ({ x: nil }).sanitize_value(:x, :float).dig(:x)
    assert_equal 0, ({ x: 'nil' }).sanitize_value(:x, :float).dig(:x)

    # times
    time = Time.at(1827320999)
    time_str = time.to_s
    assert_equal time, ({ x: time_str }).sanitize_value(:x, :datetime).dig(:x)
    assert_equal time.to_date, ({ x: time_str }).sanitize_value(:x, :date).dig(:x)
  end

  def test_sanitize_value__does_not_mod_original
    orig = { x: '1' }
    orig.sanitize_value(:x, :float)
    assert_equal '1', orig.dig(:x)
  end

  def test_sanitize
    expected = {
      a: 1,
      b: Time.at(1827320999).to_date,
    }

    actual = { a: '1', b: Time.at(1827320999).to_s }.sanitize(a: :float, b: :date)

    assert_equal expected, actual
  end

  def sanitize__does_not_mod_orig
    orig = { x: '1' }
    orig.sanitize(x: :float)
    assert_equal '1', orig.dig(:x)
  end

  def test_to_os
    os = { x: 1, y: { a: [1,2,3] } }.to_os

    assert_equal 1, os.x
    assert_equal [1,2,3], os.y.a
  end
end
